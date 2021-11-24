#include "protheus.ch"
#include "topconn.ch"


User Function ESP2NOME // MostraFunc(OK)

//U_MostraFunc(ProcName(),FunName())

Return ("Customiza็๕es Pelican")
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fNovoXNU บAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fNovoXNU()

Local lProc   := .T.
Local cDirXnu := ""
Local aRetXnu := {}
Local aXnuOK  := {}
Local aRetFunc:= {}
Local aCriaMnu:= {}

// Chama tela de parametros
If lProc
	cDirXnu := fTelaParam()
	lProc   := IIf(Empty(cDirXnu),.F.,.T.)
EndIf

//Ler arquivos da pasta definida
If lProc
	cDirXnu := AllTrim(cDirXnu)
	cDirXnu := Upper(cDirXnu)
	
	Processa({ || aRetXnu := fLerDir(cDirXnu) })
	lProc   := IIf(Len(aRetXnu)>0,.T.,.F.)
EndIf

//Valida os XNU em uso
If lProc
	Processa({ || aXnuOK := fValidaXNU(aRetXnu) })
EndIf

//Localizando rotinas customizadas
If lProc
	Processa({ || aRetFunc := fPesqFunc(aXnuOK) })
	lProc   := IIf(Len(aRetFunc)>0,.T.,.F.)
EndIf

//Criando novo menu
If lProc
	Processa({ || aCriaMnu := fCriaXNU(aRetFunc) })
	lProc := aCriaMnu[1]
EndIf

//Criando novo menu
If lProc
	MsgInfo("Processo finalizado com sucesso!"+Chr(13)+Chr(10)+aCriaMnu[2])
Else
	Alert("Processo cancelado!")
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfTelaParamบAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fTelaParam()

Local lRet      := .F.
Local aRetArq   := {}

local cDirXnu   := ""

Local aPrgRet   := {}
Local aPergta   := {}
Local mv_par01  := ""

Local cRootDir  := AllTrim(GetSrvProfString("RootPath",""))

aAdd(aPergta,{6,"Diret๓rio dos *.XNU",mv_par01,"",".F.",".F.",90,.T.," |*.","\",GETF_RETDIRECTORY})

If ParamBox(aPergta,"Menu das Customiza็๕es",@aPrgRet,,,,,,,AllTrim(FunName())+"DIRXNU",.T.,.T.)
	cDirXnu := AllTrim(aPrgRet[1])
	Do Case
		Case SubStr(cRootDir,Len(cRootDir),1) == "\" .And. SubStr(cDirXnu,1,1) == "\"
			cDirXnu := cRootDir+SubStr(cDirXnu,2,Len(cDirXnu))
		Case SubStr(cRootDir,Len(cRootDir),1) != "\" .And. SubStr(cDirXnu,1,1) != "\"
			cDirXnu := cRootDir+"\"+cDirXnu
		OtherWise
			cDirXnu := cRootDir+cDirXnu
	EndCase
Else
	cDirXnu := ""
EndIf

Return(cDirXnu)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fLerDir  บAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fLerDir(cDirXnu)

Local x       := 00
Local y       := 00
Local aRet    := {}
Local aDir    := {}
Local aSubDir := {}
Local lSubDir := .T.

//Localiza sub diretorios
If lSubDir
	aDir := Directory(cDirXnu+"*.*","D")
	aSort(aDir,,,{|x,y| x[5] > y[5] })

	//Processamento da regua
	ProcRegua(Len(aDir))

	For x:=1 To Len(aDir)
		//Processamento da regua
		IncProc("Localizando sub diretorios...")

		If aDir[x][5] == "D"
			//Adicionar os sub diretorios
			If !(AllTrim(aDir[x][1]) $ ".." )
				aAdd(aSubDir,AllTrim(aDir[x][1]))
			EndIf
		ElseIf Len(aSubDir) > 0
			//Sair do Loop
			x := Len(aDir)
		EndIf
	Next x
EndIf

//Ler todos os XNU da raiz
aDir := {}
aDir := Directory(cDirXnu+"*.XNU")
//Processamento da regua
ProcRegua(Len(aDir))
//Ler todos os XNU da raiz
For x:=1 To Len(aDir)
	//Processamento da regua
	IncProc("01 de 02 - Localizando arquivos *.xnu ...")

	aAdd(aRet, { cDirXnu, AllTrim(aDir[x][1]) })
Next x

//Processamento da regua
ProcRegua(Len(aSubDir))
//Ler todos os PRW dos sub diretorios
For x:=1 To Len(aSubDir)
	//Processamento da regua
	IncProc("02 de 02 - Localizando arquivos *.xnu ...")

	aDir := {}
	aDir := Directory(cDirXnu+aSubDir[x]+"\*.XNU")
	For y:=1 To Len(aDir)
		aAdd(aRet, { cDirXnu+aSubDir[x]+"\", AllTrim(aDir[y][1]) })
	Next y
Next x

Return(aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfValidaXNUบAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fValidaXNU(aXnu)

Local x         := 00
Local	aRet      := {}
Local	aFora     := {}
Local	aUsados   := {}
Local	aUsuarios := AllUsers(.T.)
Local	aModulos  := RetModName(.T.)
Local	nModulos  := 00
Local cRootDir  := Upper(AllTrim(GetSrvProfString("RootPath","")))

//Carrega contador
ProcRegua(Len(aUsuarios))

//Processa contador
IncProc("Localizando XNU dos usuแrios habilitado...")

//Todos usuแrios, menos o administrador
For x:=1 To Len(aUsuarios)
	//Processa contador
	IncProc("Localizando XNU dos usuแrios habilitado...")

	//Verifica se usuแrio nใo estแ bloqueado
	lOk := .T.

	//Verifica se usuแrio estแ bloqueado
	If aUsuarios[x][1][17]
		lOk := .F.
	EndIf

	//Verifica se usuแrio nใo ้ o ADMIN
	If aUsuarios[x][1][1] == "000000"
		lOk := .F.
	EndIf
	
	//Se tudo OK, siga em frente
	If lOk
		//Todos menus
		For y:=1 To Len(aUsuarios[x][3])
			//Verifica se menu esta ativo
			If SubStr(aUsuarios[x][3][y],3,1) != "X"
				nModulo := Val(SubStr(aUsuarios[x][3][y],1,2))

				cVar := Upper(AllTrim(SubStr(aUsuarios[x][3][y],4,Len(aUsuarios[x][3][y]))))
				nPos := AtR("\",cVar)

				cDirXnu := SubStr(cVar,1,nPos)
				cArqXnu := SubStr(cVar,nPos+1,Len(cVar))

				//Grava informa็ใo no Array
				If aScan(aUsados,{|f| f[2]+f[3] == cDirXnu+cArqXnu}) == 0
					aAdd(aUsados,{nModulo,cDirXnu,cArqXnu})
				EndIf
			EndIf
		Next y
	EndIf

Next x

//Ordena Array
aSort(aUsados,,,{|x,y| x[2] + StrZero(x[1],3) + x[3]  <  y[2] + StrZero(y[1],3) + y[3] })

//Analisa XNU usados e arquivos XNU da da pasta informada
If Len(aUsados) > 0 .And. Len(aXnu) > 0
	//Carrega contador
	ProcRegua(Len(aXnu))
   //Analisa arquivo por arquivo
	For x:=1 To Len(aXnu)
		IncProc("Analisando XNU dos usuแrios habilitado...")
		cVar := StrTran(aXnu[x][1],cRootDir,"")
		cVar := IIf(SubStr(cVar,1,1)=="\","","\")+cVar
		nPos := aScan(aUsados,{|f| f[2]+f[3] == cVar+aXnu[x][2]})
		If nPos > 0
			nPosModulo  := aScan(aModulos,{|f| StrZero(f[1],3) == StrZero(aUsados[nPos][1],3) })
			cNomeModulo := aModulos[nPosModulo][2] + " - " + aModulos[nPosModulo][3]
			//Aqui estใo todos os XNU que sใo usados
			aAdd(aRet,{aXnu[x][1],aXnu[x][2],aUsados[nPos][1],cNomeModulo})
		Else
			//Aqui estใo todos os XNU que nใo sใo usados
			aAdd(aFora,{aXnu[x][1],aXnu[x][2],0,""})
		EndIf
	Next
EndIf

Return(aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fPesqFuncบAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fPesqFunc(aRetArqs)

Local x        := 00
Local y        := 00
Local cArqXNU  := ""
Local aRetXnu  := {}
Local aRetFunc := {}

//Ordena por modulo
aSort(aRetXnu,,,{|x,y| StrZero(x[3],3) < StrZero(y[3],3) })

//Carrega contador
ProcRegua(Len(aRetXnu))

//Grupo por chave
cGrupoXNU := "000001"
cLinhaSeq := "001"
For x:=1 To Len(aRetArqs)
	//Zera Variaveis
	cArqXNU   := ""
	aRetXnu   := {}
	aAchaFunc := {}

	//Processa contador
	IncProc("Procurando Customiza็ใo no XNU...")
	cArqXNU := AllTrim(aRetArqs[x][1])+AllTrim(aRetArqs[x][2])
	Processa({ || aRetXnu   := fLendoXnu(cArqXNU,x,Len(aRetArqs)) })
	Processa({ || aAchaFunc := fAchaFunc(aRetXnu) })

	If Len(aAchaFunc) > 0
		For y:=1 To Len(aAchaFunc)
			cLinhaSeq := "001"
			For z:=1 To Len(aAchaFunc[y])
				aAdd(aRetFunc,{cGrupoXNU,cLinhaSeq,aRetArqs[x][1],aRetArqs[x][2],aRetArqs[x][4],aAchaFunc[y][z]})
				cLinhaSeq := Soma1(cLinhaSeq)
			Next z
			cGrupoXNU := Soma1(cGrupoXNU)
		Next y
	EndIf

Next x

Return(aRetFunc)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fLendoXnuบAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fLendoXnu(cArqXNU,nDe,nAte)

Local aRet := {}
Local cLinha  := ""
Local nCount  := 00

Default cArqXNU := ""

//Se variavel do arquivo vazia
If Empty(cArqXNU)
	Return(aRet)
EndIf

//Se arquivo nใo existe
If !File(cArqXNU)
	Return(aRet)
EndIf

//Abre arquivo
FT_FUSE(cArqXNU)

//Carrega contador
ProcRegua(FT_FLASTREC())

//Posiciona no primeiro registro
FT_FGOTOP()

//Le arquivo linha a linha
While !FT_FEOF()
	nCount ++
	//Processa contador
	IncProc(StrZero(nDe,3)+" de "+StrZero(nAte,3)+" - Lendo linhas do XNU...")
	
	//Carrega uma linha do arquivo
	cLinha := ""
	cLinha := FT_FREADLN()
	
	//Carrega Array
	aAdd(aRet,{StrZero(nCount,5),cLinha,Upper(AllTrim(cLinha)),"",cArqXNU})

	FT_FSKIP()
End

//Finaliza utiliza็ใo do arquivo
FT_FUSE()

Return(aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fAchaFuncบAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAchaFunc(aXnu)

Local x      := 00
Local aRet   := {}
Local aType3 := {}

//Carrega contador
ProcRegua(Len(aXnu))

For x:=1 To Len(aXnu)
	//Processa contador
	IncProc("Procurando fun็ใo customizada no XNU...")

	lOk := .T.
	If lOk .And. !("03" $ aXnu[x][3])
		lOk := .F.
	EndIf
	If lOk .And. !("<TYPE" $ aXnu[x][3])
		lOk := .F.
	EndIf
	If lOk .And. !("</TYPE" $ aXnu[x][3])
		lOk := .F.
	EndIf
	//Ultima tentativa
	If !lOk .And. "FUNCTION" $ aXnu[x][3]
		lOk := .T.
		If lOk .And. !("U_" $ aXnu[x][3])
			lOk := .F.
		EndIf
		If lOk .And. !("<FUNCTION" $ aXnu[x][3])
			lOk := .F.
		EndIf
		If lOk .And. !("</FUNCTION" $ aXnu[x][3])
			lOk := .F.
		EndIf
	EndIf

	//Registra a posi็ใo do fontes customizados 
	//que foram localizados no xnu em questใo
	If lOk
		aAdd(aType3,{aXnu[x][1],aXnu[x][2]})
	EndIf
Next x

//Prepara retorno pegando a chave inteira do fonte customizado
For x:=1 To Len(aType3)
	nPos    := aScan(aXnu, { |f| f[1] == aType3[x][1] } )
	nPosIni := 0
	nPosFim := 0

	//Procura primeira posi็ใo da chave
	lLoop   := .T.
	While lLoop	
		If "<MENUITEM" $ Upper(aXnu[nPos][02])
			nPosIni := nPos
			lLoop   := .F.
		Else
			nPos --
		EndIf
	End

	//Procura ultima posi็ใo da chave
	lLoop   := .T.
	While lLoop	
		If "</MENUITEM" $ Upper(aXnu[nPos][02])
			nPosFim := nPos
			lLoop   := .F.
		Else
			nPos ++
		EndIf
	End

	//Verificar se fun็ใo estแ compilada no repositorio
	lOk := .F.
	For y := nPosIni To nPosFim
		If "FUNCTION" $ Upper(aXnu[y][3])
			lOk := fFuncExist(aXnu[y][3])
		EndIf
	Next y

	//Grava chave inteira no array de retorno
	If lOk
		aAdd(aRet,{})
		For y := nPosIni To nPosFim
			aAdd(aRet[Len(aRet)], OemToAnsi(aXnu[y][02]) )
		Next y
	EndIf

Next x

Return(aRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AtR      บAutor  ณ Felipe A. Melo     บ Data ณ  09/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtR(cPesq,cString)

Local nRet      := 0
Local nQtd      := 0

Local lLoop     := .T.

Default cPesq   := ""
Default cString := ""

nQtd := Len(cString)

While lLoop
	//Verifica caracter
	If cPesq == SubStr(cString,nQtd,1)
		lLoop := .F.
	EndIf
	//Subtrai caso nใo tenha localizado
	If lLoop
		nQtd --
	EndIf
	//Verifica se ้ o fim da analise
	If nQtd == 0
		lLoop := .F.
	EndIf
End

nRet := nQtd

Return(nRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fCriaXNU บAutor  ณ Felipe A. Melo     บ Data ณ  16/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaXNU(aChvXnu)

Local lRet    := .F.

Local cNewXNU := ""
Local lLoop   := .T.
Local nSequ   := 1
Local nHdl	  := 0

Local cCRLF	  := Chr(13)+Chr(10)

Local nPosIni := 0
Local nPosTam := 0
Local nPesqui := 0
Local cFuncao := ""

Local aFuncDupl := {}
Local aFuncaoOk := {}

Default aChvXnu := {}

//Procura por duplicidades
ProcRegua(Len(aChvXnu))

For x:=1 To Len(aChvXnu)
	//Processa contador
	IncProc("Procurando fun็ใo duplicada na sele็ใo realizada...")
	If "<FUNCTION>" $ Upper(aChvXnu[x][6])
		//Posi็ใo inicial
		nPosIni := At("<FUNCTION>" ,Upper(aChvXnu[x][6]) )
		nPosIni += 10
		
		//Tamanho do nome da fun็ใo
		nPosTam := At("</FUNCTION>",Upper(aChvXnu[x][6]) )
		nPosTam -= nPosIni
		
		cFuncao := SubStr(aChvXnu[x][6],nPosIni,nPosTam)
		cFuncao := AllTrim(cFuncao)
		cFuncao := Upper(cFuncao)
		
		nPesqui := aScan(aFuncaoOk,cFuncao)
		
		If nPesqui > 0
			aAdd(aFuncDupl,aChvXnu[x][1])
		Else
			aAdd(aFuncaoOk,cFuncao)
		EndIf
	EndIf
Next x 

//Ordena por modulo
aChvXnu := aSort(aChvXnu,,,{|x,y| x[5]+x[1]+x[2] < y[5]+y[1]+y[2] })


//Define nome do arquivo
cNewXNU := "E:\Protheus10\Bin\sigaesp2.xnu"
While lLoop
	//Cria novo arquivo caso exista
	If File(cNewXNU)
		cNewXNU := "E:\Protheus10\Bin\sigaesp2_"+StrZero(nSequ,3)+".xnu"
		nSequ ++
	Else
		lLoop := .F.
	Endif
End


If Len(aFuncaoOk) > 0
	//Trata para nome do arquivo  ser maiusculo
	cNewXNU := AllTrim(Upper(cNewXNU))
	
	//Cria arquivo txt
	nHdl := fCreate(cNewXNU)

	//----------------------------------------------
	cVarTemp := '<ApMenu>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '	<DocumentProperties>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '		<Module></Module>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '		<Version>10.1</Version>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '	</DocumentProperties>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '	<Menu Status="Enable">'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '		<Title lang="pt">&Customiza็๕es</Title>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '		<Title lang="es">&Customiza็๕es</Title>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

	cVarTemp := '		<Title lang="en">&Customiza็๕es</Title>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
	//----------------------------------------------

	//Cria arquivo XNU
	ProcRegua(Len(aChvXnu))
	cGrupoXNU := ""
	
	For x:=1 To Len(aChvXnu)
		//Processa contador
		IncProc("Criando arquivo xnu...")
      
		If cGrupoXNU != aChvXnu[x][5]
			If !Empty(cGrupoXNU)
				//----------------------------------------------
				cVarTemp := '		</Menu>'
				fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
				//----------------------------------------------
			EndIf

			cGrupoXNU := aChvXnu[x][5]
			//----------------------------------------------
			cVarTemp := '		<Menu Status="Enable">'
			fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

			cVarTemp := '			<Title lang="pt">'+cGrupoXNU+'</Title>'
			fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

			cVarTemp := '			<Title lang="es">'+cGrupoXNU+'</Title>'
			fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )

			cVarTemp := '			<Title lang="en">'+cGrupoXNU+'</Title>'
			fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
			//----------------------------------------------

		EndIf
		
		//Verifica se serแ adicionado ao menu
		If aScan(aFuncDupl,aChvXnu[x][1]) == 0
			//Alimenta arquivo
			fWrite( nHdl,aChvXnu[x][6]+cCRLF,Len(aChvXnu[x][6]+cCRLF ) )
		EndIf


	Next x

	//----------------------------------------------
	cVarTemp := '		</Menu>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
	
	cVarTemp := '	</Menu>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
	
	cVarTemp := '</ApMenu>'
	fWrite( nHdl,cVarTemp+cCRLF,Len(cVarTemp+cCRLF ) )
	//----------------------------------------------
	
	//Finaliza processo e fecha arquivo txt
	fClose(nHdl)
	
	//Renomeia arquivo de minusculo para maiusculo
	FRenameEx(Lower(cNewXNU),Upper(cNewXNU))
	
EndIf

//Verifica se arquivo foi criado
If File(cNewXNU)
	lRet := .T.
EndIf

Return({lRet,cNewXNU})

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFuncExistบAutor  ณ Felipe A. Melo     บ Data ณ  16/10/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP10                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fFuncExist(cPesqFunc)

Local lRet    := .T.
Local nPosDe  := 00
Local nPosAte := 00
Local nTamanho:= 00
Default cPesqFunc := ""

//Tratando variavel antes de testar fun็ใo

nPosDe    := AT( ">",cPesqFunc)+1
nPosAte   := AT("</",cPesqFunc)
nTamanho  := nPosAte-nPosDe
cPesqFunc := SubStr(cPesqFunc,nPosDe,nTamanho)
cPesqFunc := IIf(SubStr(cPesqFunc,1,2)=="U_",SubStr(cPesqFunc,3,Len(cPesqFunc)),cPesqFunc)

//Testando fun็ใo
If FindFunction("U_"+cPesqFunc)
	lRet := .T.
Else
	lRet := .F.
EndIf

Return(lRet)