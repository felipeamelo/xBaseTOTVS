#include "protheus.ch"
#include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � fNovoPRJ �Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fNovoPRJ()

Local aArquivo := {}

Processa({|| fLendoArqu(@aArquivo) },OemToAnsi("Lendo PRJ"),OemToAnsi("Processando..."),.F.)

Processa({|| fTrataArqu(@aArquivo) },OemToAnsi("Tratando PRJ"),OemToAnsi("Processando..."),.F.)

Processa({|| fCriaArqui(@aArquivo) },OemToAnsi("Criando PRJ"),OemToAnsi("Processando..."),.F.)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fLendoArqu�Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fLendoArqu(aArquivo)

Local cArqPRJ := "E:\Protheus10\rdmake\PROJETO_PELICAN.PRJ"
Local cLinha  := ""
Local nCount  := 00

//Abre arquivo
FT_FUSE(cArqPRJ)

//Carrega contador
ProcRegua(FT_FLASTREC())

//Posiciona no primeiro registro
FT_FGOTOP()

//Le arquivo linha a linha
While !FT_FEOF()
	nCount ++
	//Processa contador
	IncProc("Lendo linhas do projeto...")
	
	//Carrega uma linha do arquivo
	cLinha := ""
	cLinha := FT_FREADLN()
	cLinha := Upper(cLinha)
	
	//Carrega Array
	aAdd(aArquivo,{StrZero(nCount,5),cLinha,AllTrim(cLinha),""})

	FT_FSKIP()
End

//Finaliza utiliza��o do arquivo
FT_FUSE()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fTrataArqu�Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fTrataArqu(aArquivo)

Local x         := 00
Local xLin      := 00
Local yLin      := 00
Local cQuery    := ""
Local nQtdRec   := 00
Local aExclui   := {}
Local aPrw_OK   := {}
Local aP99_Fora := {}

//Ordena para facilitar tratamento
aSort(aArquivo,,,{|o,p|o[3]<p[3]})

cQuery += " SELECT "
cQuery += " P99_PRG "
cQuery += " FROM P99010 (NOLOCK) "
cQuery += " WHERE D_E_L_E_T_ = '' "
cQuery += " AND P99_PRG != '' "
cQuery += " GROUP BY P99_PRG "
cQuery += " ORDER BY P99_PRG "

//Finaliza alias caso em uso
If Select("SQL") != 0 ; SQL->(dbCloseArea()) ; EndIf

TcQuery cQuery ALIAS SQL NEW

//Conta registros
DbSelectArea("SQL")
SQL->(DbGoTop())
Count to nQtdRec

//Carrega contador
ProcRegua(Len(aArquivo))

//Localiza primeira e ultima linha a ser pesquisada
For x:=1 To Len(aArquivo)
	//Processa contador
	IncProc("Definindo prw que ser�o mantidos no projeto...")
	If xLin == 0 .And. yLin == 0 .And.  ("FILE" $ aArquivo[x][2] .And. "\RDMAKE\" $ aArquivo[x][2])
		xLin := x
	EndIf
	If xLin != 0 .And. yLin == 0  .And. !("FILE" $ aArquivo[x][2] .And. "\RDMAKE\" $ aArquivo[x][2])
		yLin := x
	EndIf
	//Marca linhas que ser�o exportadas novamente para o arquivo
	If xLin == 0
		aArquivo[x][4] := "OK"
	EndIf
	//Marca linhas que ser�o exportadas novamente para o arquivo
	If yLin != 0
		aArquivo[x][4] := "OK"
	EndIf
Next x

//Carrega contador
ProcRegua(nQtdRec)

SQL->(DbGoTop())
If SQL->(!Eof())
	While SQL->(!Eof())
		//Processa contador
		IncProc("Definindo prw que ser�o mantidos no projeto...")
	   
	   //Trata se PRW foi encontrado no Projeto
	   lAchou := .F.
	   
		//Verifica se arquivo est� no projeto e marca linha
		For x:=xLin To yLin
			If Upper(AllTrim(SQL->P99_PRG)) $ aArquivo[x][3]
				aArquivo[x][4] := "OK"
				lAchou         := .T.
				x := yLin
			EndIf
		Next x
		
		//Caso PRW n�o localizado no projeto, adicionar no array
		If !lAchou
			aAdd(aP99_Fora,Upper(AllTrim(SQL->P99_PRG)))
		EndIf
		
		SQL->(DbSkip())
	End
EndIf

//Apenas por curiosidade, mostra arquivos que ser�o desconsiderados
For x:=xLin To yLin
	If Empty(aArquivo[x][4])
		aAdd(aExclui,aArquivo[x][3])
	Else
		aAdd(aPrw_OK,aArquivo[x][3])
	EndIf
Next x

//Volta para ordena��o original
aSort(aArquivo,,,{|o,p|o[1]<p[1]})

//Desmarca linhas que n�o ser�o ser�o exportadas
//Refaz contador de arquivos por pasta
fAjustaArr(@aArquivo)

//Copia arquivos para nova pasta
//Ajusta array para apontar pra nova pasta
fCopiaPrw(@aArquivo)

//aExclui   -> Array com os PRW que ser�o excluidos do projeto
//aPrw_OK   -> Array com os PRW que ser�o mantidos no projeto
//aP99_Fora -> Array com os PRW que n�o constam no projeto

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fCriaArqui�Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fCriaArqui(aArquivo)

Local cArqPRJ := ""
Local cCRLF	  := Chr(13)+Chr(10)
Local nHdl	  := 0
Local lLoop   := .T.
Local nSequ   := 1

While lLoop
	//Define nome do arquivo
	cArqPRJ := "E:\Protheus10\rdmake_mp11\PROJETO_PELICAN_MP11_"+StrZero(nSequ,3)+".PRJ"

	//Cria novo arquivo caso exista
	If File(cArqPRJ)
		nSequ ++
	Else
		lLoop := .F.
	Endif
End

//Trata para nome do arquivo  ser maiusculo
cArqPRJ := AllTrim(Upper(cArqPRJ))

//Cria arquivo txt
nHdl := fCreate(cArqPRJ)

//Carrega contador
ProcRegua(Len(aArquivo))

For x:=1 To Len(aArquivo)
	//Processa contador
	IncProc("Criando novo projeto...")
	//Alimenta arquivo caso OK
	If aArquivo[x][4] == "OK"
		//Alimenta arquivo
		fWrite( nHdl,aArquivo[x][2]+cCRLF,Len(aArquivo[x][2]+cCRLF ) )
	EndIf
Next x

//Finaliza processo e fecha arquivo txt
fClose(nHdl)

//Renomeia arquivo de minusculo para maiusculo
FRenameEx(Lower(cArqPRJ),Upper(cArqPRJ))

MsgInfo("Projeto criado com sucesso."+cCRLF+cArqPRJ)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fCriaArqui�Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fAjustaArr(aArquivo)

Local x      := 0
Local nRegtr := 0
Local nConta := 1
Local lApaga := .F.

//Carrega contador
ProcRegua(Len(aArquivo))

//Apaga linhas que n�o dever�o ir pro projeto
For x:=1 To Len(aArquivo)
	//Processa contador
	IncProc("Apagando linhas do projeto...")

	If lApaga
		If nConta <= 2
			nConta ++
			aArquivo[x][4] := ""
		Else
			lApaga := .F.
			nConta :=  1
		EndIf
	EndIf
	If !lApaga .And. Empty(aArquivo[x][4])
		lApaga := .T.
	EndIf
Next x


//Carrega contador
ProcRegua(Len(aArquivo))

//Faz a recontagem dos PRW por Pasta do projeto
nRegtr := 0
nConta := 0
For x:=1 To Len(aArquivo)
	//Processa contador
	IncProc("Refazendo contagem dos prw...")
	If "FILESCOUNT=" $ aArquivo[x][3]
		//Ajusta chave FILESCOUNT conforme nova contagem
		If nRegtr != 0
			nPos := At("=",aArquivo[nRegtr][2])
			aArquivo[nRegtr][2] := SubStr(aArquivo[nRegtr][2],1,nPos)+AllTrim(Str(nConta))

			nPos := At("=",aArquivo[nRegtr][3])
			aArquivo[nRegtr][3] := SubStr(aArquivo[nRegtr][3],1,nPos)+AllTrim(Str(nConta))
		EndIf
		nRegtr := x
		nConta := 0
	EndIf
	If "\RDMAKE\" $ aArquivo[x][3] .And. "OK" $ aArquivo[x][4]
		nConta ++
	EndIf

	//Trata ultimo grupo de arquivos
	If Len(aArquivo) == x+1
		If nRegtr != 0
			nPos := At("=",aArquivo[nRegtr][2])
			aArquivo[nRegtr][2] := SubStr(aArquivo[nRegtr][2],1,nPos)+AllTrim(Str(nConta))

			nPos := At("=",aArquivo[nRegtr][3])
			aArquivo[nRegtr][3] := SubStr(aArquivo[nRegtr][3],1,nPos)+AllTrim(Str(nConta))
		EndIf
	EndIf

Next x

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fCopiaPrw �Autor  � Felipe A. Melo     � Data �  28/08/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fCopiaPrw(aArquivo)

Local x      := 0
Local cPastaOrigem  := "E:"
Local cPastaDestino := "E:\Protheus10\rdmake_mp11"

Local cArqPRJ := ""
Local lLoop   := .T.
Local nSequ   := 1
Local cTodosArq := ""

While lLoop
	//Define nome do arquivo
	cArqPRJ := cPastaDestino+"\PROJETO_PELICAN_MP11_"+StrZero(nSequ,3)+".PRJ"

	//Cria novo arquivo caso exista
	If File(cArqPRJ)
		nSequ ++
	Else
		lLoop := .F.
		cPastaDestino += "\"+StrZero(nSequ,3)
	Endif
End

//Cria pasta da sequencia
MontaDir(cPastaDestino+"\")

//Cria pasta USADOS
MontaDir(cPastaDestino+"\USADOS\")

//Cria pasta NAOUSADOS
MontaDir(cPastaDestino+"\NAOUSADOS\")

//Cria pasta FORADOPROJETO
MontaDir(cPastaDestino+"\FORADOPROJETO\")

//Carrega contador
ProcRegua(Len(aArquivo))

For x:=1 To Len(aArquivo)
	//Processa contador
	IncProc("Copiando prw para novas pastas...")
	If "\RDMAKE\" $ aArquivo[x][3]
		lLoop := .T.
		nPos  :=  1
		cArq  := ""
		While lLoop
			If At("\",SubStr(aArquivo[x][3],nPos,Len(aArquivo[x][3]))) > 0
				nPos += At("\",SubStr(aArquivo[x][3],nPos,Len(aArquivo[x][3])))
			Else
				lLoop := .F.
			EndIf
		End
		cArq := SubStr(aArquivo[x][3],nPos,Len(aArquivo[x][3]))
		cArr := AllTrim(StrTran(aArquivo[x][3],"FILE",""))
		cTodosArq += "|"+cArq+"|"
		
		If "OK" $ aArquivo[x][4]
			aArquivo[x][2] := StrTran(aArquivo[x][2],cArr,"\PROTHEUS10\RDMAKE_MP11\"+StrZero(nSequ,3)+"\USADOS\"+cArq)
			aArquivo[x][3] := StrTran(aArquivo[x][3],cArr,"\PROTHEUS10\RDMAKE_MP11\"+StrZero(nSequ,3)+"\USADOS\"+cArq)

			Copy File &(cPastaOrigem+cArr) To &(cPastaDestino+"\USADOS\"+cArq)
			FRenameEx(Lower(cPastaDestino+"\USADOS\"+cArq),Upper(cPastaDestino+"\USADOS\"+cArq))
		Else
			Copy File &(cPastaOrigem+cArr) To &(cPastaDestino+"\NAOUSADOS\"+cArq)
			FRenameEx(Lower(cPastaDestino+"\NAOUSADOS\"+cArq),Upper(cPastaDestino+"\NAOUSADOS\"+cArq))
		EndIf
	EndIf
Next x


//cTodosArq
//Verifica os arquivos que n�o est�o no projeto
cPastaOrigem := "E:\Protheus10\rdmake\"
aRetArq := fLerPasta(cPastaOrigem)

//Carrega contador
ProcRegua(Len(aRetArq))
For x:=1 To Len(aRetArq)
	IncProc("Copiando prw para novas pastas...")
	If !("|"+Upper(aRetArq[x][2])+"|" $ Upper(cTodosArq))
		Copy File &(aRetArq[x][1]+aRetArq[x][2]) To &(cPastaDestino+"\FORADOPROJETO\"+aRetArq[x][2])
		FRenameEx(Lower(cPastaDestino+"\FORADOPROJETO\"+aRetArq[x][2]),Upper(cPastaDestino+"\FORADOPROJETO\"+aRetArq[x][2]))
	EndIf
Next x

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � fLerPasta�Autor  � Felipe A. Melo     � Data �  14/09/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fLerPasta(cPasta)

Local x       := 00
Local y       := 00
Local aRet    := {}
Local aDir    := {}
Local aSubDir := {}

//Localiza sub diretorios
aDir := Directory(cPasta+"*.*","D")
aSort(aDir,,,{|x,y| x[5] > y[5] })
For x:=1 To Len(aDir)
	If aDir[x][5] == "D"
		//Adicionar os sub diretorios
		If !(AllTrim(aDir[x][1]) $ "..")
			aAdd(aSubDir,AllTrim(aDir[x][1]))
		EndIf
	ElseIf Len(aSubDir) > 0
		//Sair do Loop
		x := Len(aDir)
	EndIf
Next x

//Ler todos os PRW da raiz
aDir := {}
aDir := Directory(cPasta+"*.PRW")
For x:=1 To Len(aDir)
	aAdd(aRet, { cPasta, AllTrim(aDir[x][1]) })
Next x

//Ler todos os PRX da raiz
aDir := {}
aDir := Directory(cPasta+"*.PRX")
For x:=1 To Len(aDir)
	aAdd(aRet, { cPasta, AllTrim(aDir[x][1]) })
Next x

//Ler todos os PRW dos sub diretorios
For x:=1 To Len(aSubDir)
	aDir := {}
	aDir := Directory(cPasta+aSubDir[x]+"\*.PRW")
	For y:=1 To Len(aDir)
		aAdd(aRet, { cPasta+aSubDir[x]+"\", AllTrim(aDir[y][1]) })
	Next y
Next x

//Ler todos os PRW dos sub diretorios
For x:=1 To Len(aSubDir)
	aDir := {}
	aDir := Directory(cPasta+aSubDir[x]+"\*.PRX")
	For y:=1 To Len(aDir)
		aAdd(aRet, { cPasta+aSubDir[x]+"\", AllTrim(aDir[y][1]) })
	Next y
Next x

Return(aRet)