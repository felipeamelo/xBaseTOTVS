#include "totvs.ch"
#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "protheus.ch"

//+----------------------------------------------------------------------------------------------------------------------------------------------
//Funções principais
//## U_AjustP12 => Esta rotina ajusta os erros que deram na migração para a P12
//## U_PosMigra => Esta rotina ajusta o tamanho dos campos CARGO e FUNCAO que a rotina de migração TRUNCA
//## U_UpdGpCnv => Ajusta base para execução do GPECONV
//+----------------------------------------------------------------------------------------------------------------------------------------------
//## U_AgrupFil => Esta rotina migra os registros da empresa 01 para as outras, pode executrar quantas vezes for necessário até concluir com sucesso
//## U_ApagFil  => Esta rotina apaga os registros migrados da empresa 01, após a execução desta, não pode mais executar a rotina acima
//+----------------------------------------------------------------------------------------------------------------------------------------------





//+-----------------------------------------------------------------------------------//
//|Funcao....: AgrupFil()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 20 de março de 2018, 09:00
//|Descricao.: Essa rotina irá separar as empresas por raiz do CNPJ
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function AgrupFil()
*-----------------------------------------------------------*
Local lJob   := .F.
Local cHrIni := ""
Local cHrFim := ""
Private cLogProc := Chr(13)+Chr(10)+Chr(13)+Chr(10)+"DETALHAMENTO"+Chr(13)+Chr(10)
Private aTabOrig := {}

Alert("ATENÇÃO: Executar esta rotina apenas em modo exclusivo!")
cHrIni := DtoC(Date())+" - "+Time()

If	Select('SX2') != 0
	Return()
EndIf

//Processando / Incluindo
fProcess(1)

//Fim
cHrFim := DtoC(Date())+" - "+Time()

MemoWrite("MIGRAP12.LOG","Processamento:"+Chr(13)+Chr(10)+"Hora Inicio: "+cHrIni+Chr(13)+Chr(10)+"Hora Fim: "+cHrFim+cLogProc)

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: ApagFil()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 20 de março de 2018, 09:00
//|Descricao.: Essa rotina irá apagar os registros das filiais que foram separadas/migradas
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function ApagFil()
*-----------------------------------------------------------*
Local lJob   := .F.
Local cHrIni := ""
Local cHrFim := ""
Private cLogProc := Chr(13)+Chr(10)+Chr(13)+Chr(10)+"DETALHAMENTO"+Chr(13)+Chr(10)
Private aTabOrig := {}

Alert("ATENÇÃO: Executar esta rotina apenas em modo exclusivo!")
cHrIni := DtoC(Date())+" - "+Time()

If	Select('SX2') != 0
	Return()
EndIf

//Processando / Apagando
fProcess(2)

//Fim
cHrFim := DtoC(Date())+" - "+Time()

MemoWrite("MIGRAP12.LOG","Processamento:"+Chr(13)+Chr(10)+"Hora Inicio: "+cHrIni+Chr(13)+Chr(10)+"Hora Fim: "+cHrFim+cLogProc)

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fProcess()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 06 de março de 2018, 09:00
//|Descricao.: 
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fProcess(nOpcProc)
*-----------------------------------------------------------*
Local x          :=  0
Local aNovoGrupo := {}
Local cVarFil050 := ""
Local cOrigEmp   := ""
Local cOrigFil   := ""
Local cDestEmp   := ""
Local cDestFil   := ""
Local cLoopEmp   := ""

//Identificando tabelas que tem registros
aTabOrig := {}
aTabOrig := fPsqTabReg("01","11")
aTabOrig := aSort(aTabOrig,,,{|x,y| x[1] < y[1] })

//-----------------------------------------------------------------------------------
//Empresa 01 não irá mudar
//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"010","('11','12','13','14','15','16','17','18','19','20','21')"})

//-----------------------------------------------------------------------------------
//Empresa 02
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"020","('31','32','33')"})

//-----------------------------------------------------------------------------------
//Empresa 03
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"030","('41')"})

//-----------------------------------------------------------------------------------
//Empresa 04
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"040","('51','52','53','54')"})

//-----------------------------------------------------------------------------------
//Empresa 05
//-----------------------------------------------------------------------------------
cVarFil050 := "("
cVarFil050 += "'61','62','63','64','65','66','67','68','69','6A','6B','6C','6D','6E','6F','6G','6H','6I','6J','6K','6L','6M','6N','6O','6P','6Q',"
cVarFil050 += "'6R','6S','6T','6U','6V','6W','6X','6Y','6Z','71','72','73','74','75','76','77','78','79','7A','7B','7C','7D','7E','7F','7G','7H',"
cVarFil050 += "'7I','7J','7K','7L','7M','7N','7O','7P','7Q','7R','7S','7T','7U','7V','7W','7X','7Y','7Z','8A','8B','8C','8D'"
cVarFil050 += ")"
aAdd(aNovoGrupo,{"050",cVarFil050})

//-----------------------------------------------------------------------------------
//Empresa 06
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"060","('Z1')"})

//-----------------------------------------------------------------------------------
//Empresa 07
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"070","('Z3')"})

//-----------------------------------------------------------------------------------
//Empresa 08
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"080","('W1','W2')"})

//-----------------------------------------------------------------------------------
//Empresa 09
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"090","('X1','X2')"})

//-----------------------------------------------------------------------------------
//Empresa 10
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"100","('U1','U2')"})

//-----------------------------------------------------------------------------------
//Empresa 11
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"110","('Y1')"})

//-----------------------------------------------------------------------------------
//Empresa 12
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"120","('Z2')"})

//-----------------------------------------------------------------------------------
//Empresa 13
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"130","('T1')"})

//-----------------------------------------------------------------------------------
//Empresa 14
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"140","('S1','S2','S3','S4','S5')"})
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
//Empresa 15
//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"150","('91','92')"})
//-----------------------------------------------------------------------------------

//Começar fazendo loop na nova definição dos grupos
cLoopEmp := ""
For x:=1 To Len(aNovoGrupo)

	If cLoopEmp != aNovoGrupo[x][01]
		If Select('SX2') != 0
			//Finaliza Ambiente
			RpcClearEnv()
		EndIf

		cLoopEmp := aNovoGrupo[x][01]
		cEmpAnt  := SubStr(aNovoGrupo[x][01],1,2)
		cFilAnt  := SubStr(aNovoGrupo[x][02],3,2)
		
		//Inicializa Ambiente
		RPCSetType( 3 )	//Não consome licensa de uso
		RpcSetEnv(cEmpAnt,cFilAnt)//,,,,,{ "SRA" })
	EndIf

	cOrigEmp := "010"
	cOrigFil := aNovoGrupo[x][02]
	
	cDestEmp := aNovoGrupo[x][01]
	cDestFil := aNovoGrupo[x][02]

	//Migra registros da empresas 01 para outras empresas
	If nOpcProc == 1
		//Pra cada filial, conferir se existe registro na tabela destino e apagar registros caso existe
		fApagaTab(cDestEmp,cDestFil,.T.)
	
		//Pra cada filial, copiar todos os registros da filial em questão para a nova tabela
		fCopiaTab(cOrigEmp,cDestEmp,cDestFil)
	EndIf

	//Apaga registros migrados da empresas 01
	If nOpcProc == 2
		//Pra cada filial, apagar registros da filial na tabela origem, para eliminar a duplicidade
		fApagaTab(cOrigEmp,cOrigFil,.F.)
	EndIf
	
Next x

//Finaliza Ambiente
RpcClearEnv()

//Cria as tabela CHW e LE5 vazias
fCHW_LE5()

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: fPsqTabReg()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 21 de março de 2018, 09:00
//|Descricao.: Identifica tabelas que tem registro
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fPsqTabReg(cVarEmp,cVarFil)
*-----------------------------------------------------------*
Local x    := 0
Local aRet := {}
Local aTab := {}
Local nCont:= 0
Local aFiltroSX2 := {}
Local aCamposSX2 := {}

//Grava LOG 
cLogProc += Chr(13)+Chr(10)
cLogProc += "VERIFICA TABELAS QUE TEM REGISTROS - Tempo de " + Time() + " até "

//Inicializa Ambiente
RPCSetType( 3 )	//Não consome licensa de uso
RpcSetEnv(cVarEmp,cVarFil)

aFiltroSX2 := {"","","","","","","","",""}
SX2->(DbSetOrder(1))
SX2->(DbGoTop())
While SX2->(!Eof())
	nCont ++
    
	//Não copiar as tabelas abaixo para as outras empresas
	If Upper(AllTrim(SX2->X2_CHAVE)) $ "SZY|CHW|LE5"
		SX2->(DbSkip())
		Loop
	EndIf
	
	//01 -----------------------------------------
	If nCont >= 0001 .And. nCont <= 1000
		aFiltroSX2[01] += IIf(Empty(aFiltroSX2[01]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//02 -----------------------------------------
	If nCont >= 1001 .And. nCont <= 2000
		aFiltroSX2[02] += IIf(Empty(aFiltroSX2[02]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//03 -----------------------------------------
	If nCont >= 2001 .And. nCont <= 3000
		aFiltroSX2[03] += IIf(Empty(aFiltroSX2[03]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//04 -----------------------------------------
	If nCont >= 3001 .And. nCont <= 4000
		aFiltroSX2[04] += IIf(Empty(aFiltroSX2[04]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//05 -----------------------------------------
	If nCont >= 4001 .And. nCont <= 5000
		aFiltroSX2[05] += IIf(Empty(aFiltroSX2[05]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//06 -----------------------------------------
	If nCont >= 5001 .And. nCont <= 6000
		aFiltroSX2[06] += IIf(Empty(aFiltroSX2[06]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//07 -----------------------------------------
	If nCont >= 6001 .And. nCont <= 7000
		aFiltroSX2[07] += IIf(Empty(aFiltroSX2[07]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//08 -----------------------------------------
	If nCont >= 7001 .And. nCont <= 8000
		aFiltroSX2[08] += IIf(Empty(aFiltroSX2[08]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf

	//09 -----------------------------------------
	If nCont >= 8001
		aFiltroSX2[09] += IIf(Empty(aFiltroSX2[09]),"",",")+"'"+SX2->X2_CHAVE+cVarEmp+"0'"
	EndIf
	
	SX2->(DbSkip())
End

//Retorna as tabelas que existem no BD Oracle
aTab := fTabExiste(aFiltroSX2)

//Verifica se as tabelas tem registros
aFiltroSX2 := {"","","",""}
aCamposSX2 := {{},{},{},{}}
For x:=1 To Len(aTab)
	If x >= 0001 .And. x <= 0300
		aFiltroSX2[01] += IIf(Empty(aFiltroSX2[01]),"",",")+"(SELECT COUNT(*) FROM "+aTab[x]+") AS "+aTab[x]+" "
		aAdd(aCamposSX2[1],aTab[x])
	EndIf

	//02 -----------------------------------------
	If x >= 0301 .And. x <= 0600
		aFiltroSX2[02] += IIf(Empty(aFiltroSX2[02]),"",",")+"(SELECT COUNT(*) FROM "+aTab[x]+") AS "+aTab[x]+" "
		aAdd(aCamposSX2[2],aTab[x])
	EndIf

	//03 -----------------------------------------
	If x >= 0601 .And. x <= 0900
		aFiltroSX2[03] += IIf(Empty(aFiltroSX2[03]),"",",")+"(SELECT COUNT(*) FROM "+aTab[x]+") AS "+aTab[x]+" "
		aAdd(aCamposSX2[3],aTab[x])
	EndIf

	//04 -----------------------------------------
	If x >= 0901
		aFiltroSX2[04] += IIf(Empty(aFiltroSX2[04]),"",",")+"(SELECT COUNT(*) FROM "+aTab[x]+") AS "+aTab[x]+" "
		aAdd(aCamposSX2[4],aTab[x])
	EndIf
	
Next x

//Função que retorna apenas as tabelas que tem registros
aTab := {}
aTab := fTemRegs("010",aFiltroSX2,aCamposSX2)

//Verifica se tabela é compartilhada ou exclusiva e monta arrya
For x:=1 To Len(aTab)
	SX2->(DbSetOrder(1))
	If SX2->(DbSeek(aTab[x]))
		aAdd(aRet,{SX2->X2_CHAVE,SX2->X2_MODO})
	EndIf
Next x

//Finaliza Ambiente
RpcClearEnv()

//Grava LOG
cLogProc += Time() + " - Qtde tabelas verificadas: " +AllTrim(Str(nCont))+ " Qtde tabelas com registros: "+AllTrim(Str(Len(aRet)))

Return(aRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fApagaTab()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 20 de março de 2018, 09:00
//|Descricao.: Excluir registros da tabela
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fApagaTab(cVarEmp,cVarFil,lApagModoC)
*-----------------------------------------------------------*
Local x          :=  0
Local cFiltraReg := ""
Local cCpoAlias  := ""
Local lApagar    := .T.

//Grava LOG 
cLogProc += Chr(13)+Chr(10)
cLogProc += "-----------------------------------------------------------------------------"
cLogProc += Chr(13)+Chr(10)
cLogProc += "EXCLUI REGISTROS DAS TABELAS DA EMPRESA " + cVarEmp + " - INICIO: " + Time() 

For x:=1 To Len(aTabOrig)

	//Variaveis
	lApagar    := .T.
	cCpoAlias  := IIf(SubStr(aTabOrig[x][01],1,1)=="S",SubStr(aTabOrig[x][01],2,2),aTabOrig[x][01])

	//Considerar filtro ou não
	If aTabOrig[x][02] == "E"
		cFiltraReg := " WHERE "+cCpoAlias+"_FILIAL IN "+cVarFil
	Else
		cFiltraReg := ""
	EndIf
    
	//Apagar registros quando tabela compartilhada ou não
	Do Case
		Case lApagModoC
			lApagar := .T.
			cFiltraReg := "" //aqui estamos limpando o filtro, pois desejamos apagar os registros com truncate de todas as tabelas destino!
		Case !lApagModoC .And. aTabOrig[x][02] == "E"
			lApagar := .T.
		Case !lApagModoC .And. aTabOrig[x][02] == "C"
			lApagar := .F.
	EndCase

	//Excluindo registros
	If lApagar
		fDeletaReg(aTabOrig[x][01],cVarEmp,cFiltraReg)
	EndIf
Next x

//Grava LOG
cLogProc += Chr(13)+Chr(10)
cLogProc += "EXCLUI REGISTROS DAS TABELAS DA EMPRESA " + cVarEmp + " - FIM: " + Time()
cLogProc += Chr(13)+Chr(10)
cLogProc += "-----------------------------------------------------------------------------"

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: fCopiaTab()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 20 de março de 2018, 09:00
//|Descricao.: Inclui registros na tabela
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fCopiaTab(cOrigEmp,cDestEmp,cDestFil)
*-----------------------------------------------------------*
Local x          :=  0
Local cFiltraReg := ""
Local cCpoAlias  := ""

//Grava LOG 
cLogProc += Chr(13)+Chr(10)
cLogProc += "-----------------------------------------------------------------------------"
cLogProc += Chr(13)+Chr(10)
cLogProc += "INCLUI REGISTROS NAS TABELAS DA EMPRESA " + cDestEmp + " - INICIO: " + Time()

For x:=1 To Len(aTabOrig)

	cCpoAlias  := IIf(SubStr(aTabOrig[x][01],1,1)=="S",SubStr(aTabOrig[x][01],2,2),aTabOrig[x][01])

	If aTabOrig[x][02] == "E"
		cFiltraReg := " WHERE D_E_L_E_T_ <> '*' AND "+cCpoAlias+"_FILIAL IN "+cDestFil
	Else
		cFiltraReg := " WHERE D_E_L_E_T_ <> '*' "
	EndIf

	//Copiando registros
	fIncluiReg(aTabOrig[x][01],cOrigEmp,cDestEmp,cFiltraReg)
	
Next x

//Grava LOG
cLogProc += Chr(13)+Chr(10)
cLogProc += "INCLUI REGISTROS NAS TABELAS DA EMPRESA " + cDestEmp + " - FIM: " + Time()
cLogProc += Chr(13)+Chr(10)
cLogProc += "-----------------------------------------------------------------------------"

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: fTemRegs()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 05 de março de 2018, 09:00
//|Descricao.: Excluir registros da tabela
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fTemRegs(cVarEmp,aVarFiltro,aVarCpos)
*-----------------------------------------------------------*
Local x      := 0
Local y      := 0
Local aRet   := {}
Local cQuery := ""

For y:= 1 To Len(aVarFiltro)
	cQuery := " SELECT "
	cQuery += " "+aVarFiltro[y]
	cQuery += "   FROM SM2"+cVarEmp
	cQuery += "  WHERE D_E_L_E_T_ <> '*' "
	cQuery += "    AND M2_DATA = '20111111' "
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	
	//Monta Alias
	TcQuery cQuery ALIAS "TEMP" NEW
	
	//Posiciona no 1o registro
	TEMP->(DbGoTop())
	For x:=1 To Len(aVarCpos[y])
		If &("TEMP->"+aVarCpos[y][x]+">0")
			aAdd(aRet,SubStr(aVarCpos[y][x],1,3))
		EndIf
	Next x
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
Next y

Return(aRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fTabExiste()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 05 de março de 2018, 09:00
//|Descricao.: Excluir registros da tabela
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fTabExiste(aVarFiltro)
*-----------------------------------------------------------*
Local x      :=  0
Local aRet   := {}
Local cQuery := ""

//Executa todos os fitros
For x:=1 To Len(aVarFiltro)
	cQuery := " SELECT TABLE_NAME
	cQuery += "   FROM ALL_ALL_TABLES "
	cQuery += "  WHERE TABLE_NAME IN ("+aVarFiltro[x]+") "
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	
	//Monta Alias
	TcQuery cQuery ALIAS "TEMP" NEW
	
	//Posiciona no 1o registro
	TEMP->(DbGoTop())
	
	While TEMP->(!Eof())
		aAdd(aRet,AllTrim(TEMP->TABLE_NAME))
		TEMP->(DbSkip())
	End
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
Next x

Return(aRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fDeletaReg()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 05 de março de 2018, 09:00
//|Descricao.: Excluir registros da tabela
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fDeletaReg(cVarAlias,cVarEmp,cEmpFiltro)
*-----------------------------------------------------------*
Local nRet        := 0
Default cVarAlias := ""
Default cVarEmp   := ""

//Atualiza tabela conforme dicionário
X31UpdTable(cVarAlias)

//Atualiza TOP com os ajustes
TcRefresh(cVarAlias)    

//Cria tabela caso não exista
DbSelectArea(cVarAlias)

//Grava LOG 
cLogProc += Chr(13)+Chr(10)
cLogProc += "DELETE " + cVarAlias+cVarEmp + " - Tempo de " + Time() + " até "

//Monta comando de exclusão
If Empty(cEmpFiltro)
	cQuery := ""
	cQuery := " TRUNCATE TABLE "+cVarAlias+cVarEmp+" "
Else
	cQuery := ""
	cQuery := " DELETE "+cVarAlias+cVarEmp+" "
	cQuery += cEmpFiltro
EndIf

//Para acompanhar via console
ConOut("DELETE " + cVarAlias + cVarEmp + " - Filtro: " + Alltrim(Padr(cEmpFiltro,30)) + "...")

//Executa comando
nRet := TCSQLExec(cQuery) 

If nRet != 0
	cTcErro := TcSqlError()
EndIf

//Atualiza tabela no DbAccess
DbSelectArea(cVarAlias)
TcRefresh(cVarAlias+cVarEmp)
TcRefresh(cVarAlias)    

//Grava LOG
cLogProc += Time()

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: fIncluiReg()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 05 de março de 2018, 09:00
//|Descricao.: Incluir Registros na tabela destino com base na origem
//|Observação:  
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fIncluiReg(cVarAlias,cEmpOrig,cEmpDest,cEmpFiltro)
*-----------------------------------------------------------*
Local nRet        := 0
Local cQuery      := ""
Local cQbra       := "" //Chr(13)+Chr(10)
Default cVarAlias := ""
Default cEmpOrig  := ""
Default cEmpDest  := ""
Default cEmpFiltro:= ""

//Grava LOG 
cLogProc += Chr(13)+Chr(10)
cLogProc += "INSERT " + cVarAlias+cEmpDest + " - Tempo de " + Time() + " até "

//Atualiza tabela conforme dicionário
X31UpdTable(cVarAlias)

//Atualiza TOP com os ajustes
TcRefresh(cVarAlias)    

//Cria tabela caso não exista
DbSelectArea(cVarAlias)

//Motagem Query de Inclusão
cQuery := ""
//----------------------------------------------------
cQuery := cQbra+" INSERT INTO "
cQuery += cQbra+" "+cVarAlias+cEmpDest+"( "
cQuery += cQbra+" "+fRetCampos(cVarAlias,.F.)
cQuery += cQbra+"        R_E_C_N_O_, "
cQuery += cQbra+"        D_E_L_E_T_ "
cQuery += cQbra+"       )
//----------------------------------------------------
cQuery += cQbra+" SELECT 
cQuery += cQbra+" "+fRetCampos(cVarAlias,.T.)
cQuery += cQbra+"         R_E_C_N_O_, "
cQuery += cQbra+"         D_E_L_E_T_ "
//----------------------------------------------------
cQuery += cQbra+"    FROM "+cVarAlias+cEmpOrig+" "
cQuery += cQbra+"         "+cEmpFiltro
//----------------------------------------------------
cQuery += cQbra+" "

//Para acompanhar via console
ConOut("INSERT " + cVarAlias + cEmpDest + " - Filtro: " + Alltrim(Padr(cEmpFiltro,30)) + "..." )

//Executa Insert
nRet := TCSQLExec(cQuery) 

If nRet != 0
	cTcErro := TcSqlError()
EndIf

//Refresh na Tabela
DbSelectArea(cVarAlias)
TcRefresh(cVarAlias+cEmpDest)
TcRefresh(cVarAlias)    
DbCloseArea()

//Grava LOG
cLogProc += Time()

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fRetCampos()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 06 de março de 2018, 09:00
//|Descricao.: Pesquisa campos de um determinado Alias e retorna via função
//|Observação:  
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fRetCampos(cVarAlias,lVldLOB)
*-----------------------------------------------------------*

Local cRetCpos := ""
Default lVldLOB := .F.
Default cVarAlias := ""

SX3->(DbSetOrder(1))
SX3->(DbSeek(cVarAlias))

While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cVarAlias
	
	If SX3->X3_CONTEXT != "V"
		If lVldLOB
			cRetCpos += fCpoLong(SX3->X3_CAMPO) + ", "
		Else
			cRetCpos += AllTrim(SX3->X3_CAMPO) + ", "
		EndIf
	EndIf
	
	SX3->(DbSkip())
End

Return(cRetCpos)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fExisteTab()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 06 de março de 2018, 09:00
//|Descricao.: Verifica se tabela existe no SX2
//|Observação:  
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fExisteTab(cVarAlias)
*-----------------------------------------------------------*
Local lRet        := .F.
Default cVarAlias := ""

SX2->(DbSetOrder(1))
If SX2->(DbSeek(cVarAlias))
	lRet := .T.
EndIf

(cVarAlias)->(DbSelectArea(cVarAlias))

Return(lRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fEhCompart()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 06 de março de 2018, 09:00
//|Descricao.: Verifica se tabela existe no SX2
//|Observação:  
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fEhCompart(cVarAlias)
*-----------------------------------------------------------*
Local lRet        := .F.
Default cVarAlias := ""

SX2->(DbSetOrder(1))
SX2->(DbSeek(cVarAlias))
If 	AllTrim(SX2->X2_MODO) == "C"
	lRet := .T.
EndIf

Return(lRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fEhCompart()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 06 de março de 2018, 09:00
//|Descricao.: Verifica se tabela existe no SX2
//|Observação:  
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fCpoLong(cVarCpo)
*-----------------------------------------------------------*

Local cRet       := ""
Local cTratarCpo := ""

cTratarCpo += "|CV8_DET|"
cTratarCpo += "|RA4_CONTEU|"
cTratarCpo += "|RC5_MEMO|"
cTratarCpo += "|RDT_CRITER|"
cTratarCpo += "|C2_MOPC|"
cTratarCpo += "|C6_MOPC|"
cTratarCpo += "|QO_QUEST|"
cTratarCpo += "|RM_MEMO|"
cTratarCpo += "|T6_DESCRIC|"
cTratarCpo += "|T9_DESCRIC|"
cTratarCpo += "|TF_DESCRIC|"
cTratarCpo += "|TJ_OBSERVA|"
cTratarCpo += "|TL_OBSERVA|"
cTratarCpo += "|TN_DESCRIC|"
cTratarCpo += "|TS_OBSERVA|"
cTratarCpo += "|TT_OBSERVA|"
cTratarCpo += "|TU_DESCRIC|"
cTratarCpo += "|TBB_OBSPLA|"
cTratarCpo += "|TBD_OBSERV|"
cTratarCpo += "|TCD_OBSERV|"
cTratarCpo += "|TLD_OBSERV|"
cTratarCpo += "|TLI_OBSERV|"
cTratarCpo += "|TM0_DESCRI|"
cTratarCpo += "|TM5_DESRES|"
cTratarCpo += "|TNC_DETALH|"
cTratarCpo += "|TNN_OCORRE|"
cTratarCpo += "|TO0_DESCRI|"
cTratarCpo += "|TOB_TEXTO|"
cTratarCpo += "|TP9_DESCRI|"
cTratarCpo += "|TPF_DESCRI|"
cTratarCpo += "|TSP_OBSERV|"
cTratarCpo += "|ZZ4_PARAMS|"
cTratarCpo += "|ZZA_SQL|"
cTratarCpo += "|ZZD_MENSAG|"

//Trata variavel para tirar espaços
cVarCpo := Alltrim(cVarCpo)

cRet := ""
If !Empty(cVarCpo) .And. ("|"+cVarCpo+"|" $ cTratarCpo)
	cRet := "TO_LOB("+cVarCpo+")"
Else
	cRet := cVarCpo
EndIf

Return(cRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fCHW_LE5()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 29 de março de 2018, 09:00
//|Descricao.: Essa rotina irá criar a tabela vazia para todas empresas
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fCHW_LE5()
*-----------------------------------------------------------*
Local x          :=  0
Local aNovoGrupo := {}
Local cOrigEmp   := ""
Local cOrigFil   := ""
Local cDestEmp   := ""
Local cDestFil   := ""
Local cLoopEmp   := ""

//-----------------------------------------------------------------------------------
//Empresas
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"020","('31')"})
aAdd(aNovoGrupo,{"030","('41')"})
aAdd(aNovoGrupo,{"040","('51')"})
aAdd(aNovoGrupo,{"050","('61')"})
aAdd(aNovoGrupo,{"060","('Z1')"})
aAdd(aNovoGrupo,{"070","('Z3')"})
aAdd(aNovoGrupo,{"080","('W1')"})
aAdd(aNovoGrupo,{"090","('X1')"})
aAdd(aNovoGrupo,{"100","('U1')"})
aAdd(aNovoGrupo,{"110","('Y1')"})
aAdd(aNovoGrupo,{"120","('Z2')"})
aAdd(aNovoGrupo,{"130","('T1')"})
aAdd(aNovoGrupo,{"140","('S1')"})
//-----------------------------------------------------------------------------------

//Começar fazendo loop na nova definição dos grupos
cLoopEmp := ""
For x:=1 To Len(aNovoGrupo)

	If cLoopEmp != aNovoGrupo[x][01]
		If Select('SX2') != 0
			//Finaliza Ambiente
			RpcClearEnv()
		EndIf

		cLoopEmp := aNovoGrupo[x][01]
		cEmpAnt  := SubStr(aNovoGrupo[x][01],1,2)
		cFilAnt  := SubStr(aNovoGrupo[x][02],3,2)
		
		//Inicializa Ambiente
		RPCSetType( 3 )	//Não consome licensa de uso
		RpcSetEnv(cEmpAnt,cFilAnt)//,,,,,{ "SRA" })
	EndIf

	cOrigEmp := "010"
	cOrigFil := aNovoGrupo[x][02]
	
	cDestEmp := aNovoGrupo[x][01]
	cDestFil := aNovoGrupo[x][02]
    
	//Atualiza tabela no DbAccess
	DbSelectArea("CHW")
	TcRefresh("CHW"+cDestEmp)
	TcRefresh("CHW") 

	//Atualiza tabela no DbAccess
	DbSelectArea("LE5")
	TcRefresh("LE5"+cDestEmp)
	TcRefresh("LE5") 
	
Next x

//Finaliza Ambiente
RpcClearEnv()

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: PosMigra()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 18 de junho de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function PosMigra()
*-----------------------------------------------------------*
Local x        := 0
Local aX3Cargo := {}
Local aX3Func  := {}
Local cEmpUpd  := ""

//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"010","('11')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "01"
cFilAnt  := "11"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Para tratar Update com erro no RetSqlName()
cEmpUpd := AllTrim(cEmpAnt)+"0"

//-------------------------------------------------------------
//Campos FUNCAO que serão ajustados!
//-------------------------------------------------------------
aAdd(aX3Func,{"AA1","AA1_FUNCAO"})
aAdd(aX3Func,{"ABQ","ABQ_FUNCAO"})
aAdd(aX3Func,{"ABO","ABO_FUNCAO"})
aAdd(aX3Func,{"RAL","RAL_FUNCAO"})
aAdd(aX3Func,{"RB2","RB2_FUNCAO"})
aAdd(aX3Func,{"RB4","RB4_FUNCAO"})
aAdd(aX3Func,{"RB5","RB5_FUNCAO"})
aAdd(aX3Func,{"RB7","RB7_FUNCAO"})
aAdd(aX3Func,{"RBD","RBD_FUNCAO"})
aAdd(aX3Func,{"RBE","RBE_FUNCAO"})
aAdd(aX3Func,{"RBT","RBT_FUNCAO"})
aAdd(aX3Func,{"RBU","RBU_FUNCAO"})
aAdd(aX3Func,{"RCL","RCL_FUNCAO"})
aAdd(aX3Func,{"SQG","QG_CODFUN" })
aAdd(aX3Func,{"SQS","QS_FUNCAO" })
aAdd(aX3Func,{"SR7","R7_FUNCAO" })
aAdd(aX3Func,{"SRJ","RJ_FUNCAO" })
aAdd(aX3Func,{"VAI","VAI_FUNCAO"})
aAdd(aX3Func,{"ZZV","ZZV_FUNCAO"})
aAdd(aX3Func,{"GYG","GYG_FUNCOD"})
aAdd(aX3Func,{"RIE","RIE_FUNCAO"})
aAdd(aX3Func,{"SV7","V7_FUNC"   })
aAdd(aX3Func,{"TE5","TE5_FUNCAO"})
aAdd(aX3Func,{"TFF","TFF_FUNCAO"})
aAdd(aX3Func,{"TI0","TI0_FUNCAO"})
aAdd(aX3Func,{"TJ1","TJ1_FUNC"  })
aAdd(aX3Func,{"TJ2","TJ2_FUNC"  })
aAdd(aX3Func,{"TJ5","TJ5_FUNC"  })
aAdd(aX3Func,{"TKM","TKM_FUNCAO"})
aAdd(aX3Func,{"TWN","TWN_FUNCAO"})

//-------------------------------------------------------------
//Campos CARGO que serão ajustados!
//-------------------------------------------------------------
aAdd(aX3Cargo,{"ABO","ABO_CARGO" })
aAdd(aX3Cargo,{"ABQ","ABQ_CARGO" })
aAdd(aX3Cargo,{"B07","B07_CARGO" })
aAdd(aX3Cargo,{"MA8","MA8_CARGO" })
aAdd(aX3Cargo,{"NT9","NT9_CCRGDP"})
aAdd(aX3Cargo,{"RA5","RA5_CARGO" })
aAdd(aX3Cargo,{"RA8","RA8_CARGO" })
aAdd(aX3Cargo,{"RB7","RB7_CARGO" })
aAdd(aX3Cargo,{"RBH","RBH_CARGO" })
aAdd(aX3Cargo,{"RBT","RBT_CARGO" })
aAdd(aX3Cargo,{"RBU","RBU_CARGO" })
aAdd(aX3Cargo,{"RC6","RC6_CARGO" })
aAdd(aX3Cargo,{"RCL","RCL_CARGO" })
aAdd(aX3Cargo,{"SA3","A3_CARGO"  })
aAdd(aX3Cargo,{"SQ3","Q3_CARGO"  })
aAdd(aX3Cargo,{"SQ4","Q4_CARGO"  })
aAdd(aX3Cargo,{"SQ5","Q5_CARGO"  })
aAdd(aX3Cargo,{"SQA","QA_CARGO"  })
aAdd(aX3Cargo,{"SR7","R7_CARGO"  })
aAdd(aX3Cargo,{"SRA","RA_CARGO"  })
aAdd(aX3Cargo,{"SRJ","RJ_CARGO"  })
aAdd(aX3Cargo,{"SUM","UM_CARGO"  })
aAdd(aX3Cargo,{"SV7","V7_CARG"   })
aAdd(aX3Cargo,{"ZZV","ZZV_CARGO" })
aAdd(aX3Cargo,{"RI6","RI6_CARGO" })
aAdd(aX3Cargo,{"RIE","RIE_CARGO" })
aAdd(aX3Cargo,{"TFF","TFF_CARGO" })
aAdd(aX3Cargo,{"TWN","TWN_CARGO" })

//-------------------------------------------------------------
//Ajustando dicionario
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	SX3->(DbSetOrder(2))
	If SX3->(DbSeek(aX3Func[x][2]))
		RecLock("SX3",.F.)
		SX3->X3_TAMANHO := 6
		SX3->X3_GRPSXG  := "901"
		SX3->(MsUnLock())
	EndIf
Next x

//Ajustando dicionario
For x:=1 To Len(aX3Cargo)
	SX3->(DbSetOrder(2))
	If SX3->(DbSeek(aX3Cargo[x][2]))
		RecLock("SX3",.F.)
		SX3->X3_TAMANHO := 6
		SX3->X3_GRPSXG  := "901"
		SX3->(MsUnLock())
	EndIf
Next x

//-------------------------------------------------------------
//Efetivar ajustes do SX3 no Banco de Dados
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek(aX3Func[x][1]))
		X31UpdTable(aX3Func[x][1])
	EndIf
Next x

//Efetivar ajustes do SX3 no Banco de Dados
For x:=1 To Len(aX3Cargo)
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek(aX3Cargo[x][1]))
		X31UpdTable(aX3Cargo[x][1])
	EndIf
Next x

//-------------------------------------------------------------
//Popular campos _XXFUNC com as informações dos campos PADRAO
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	fExecUpdBD(aX3Func[x][1],aX3Func[x][2],"_XXFUNC",cEmpUpd,2)
Next x

//Popular campos _XXCARG com as informações dos campos PADRAO
For x:=1 To Len(aX3Cargo)
	fExecUpdBD(aX3Cargo[x][1],aX3Cargo[x][2],"_XXCARG",cEmpUpd,2)
Next x

//Msg de fim do processo
SimNao("Fim dos ajustes!!!")

//Finaliza Ambiente
RpcClearEnv()

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: AjustP12()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function AjustP12()
*-----------------------------------------------------------*

//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"010","('11')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "01"
cFilAnt  := "11"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Atualiza tabela BD Oracle conforme SX3
X31UpdTable("C07")
X31UpdTable("C0J")
X31UpdTable("C0K")
X31UpdTable("C1A")
X31UpdTable("C1U")
X31UpdTable("C3X")
X31UpdTable("C95")
X31UpdTable("C96")
X31UpdTable("C97")
X31UpdTable("C98")
X31UpdTable("CHA")
X31UpdTable("CHY")
X31UpdTable("CUF")
X31UpdTable("CUQ")
X31UpdTable("CUY")
X31UpdTable("CUZ")
X31UpdTable("T1V")
X31UpdTable("T3E")
X31UpdTable("TMD")
X31UpdTable("C8R")
X31UpdTable("C92")
X31UpdTable("CMD")
X31UpdTable("T05")

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo(cEmpAnt)
	
//Finaliza Ambiente
RpcClearEnv()

SimNao("Processo finalizado!!!")
Return()

//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"020","('31')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "02"
cFilAnt  := "31"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()


//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"030","('41')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "03"
cFilAnt  := "41"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"040","('51')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "04"
cFilAnt  := "51"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"050","('61')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "05"
cFilAnt  := "61"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"060","('Z1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "06"
cFilAnt  := "Z1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"070","('Z3')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "07"
cFilAnt  := "Z3"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"080","('W1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "08"
cFilAnt  := "W1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"090","('X1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "09"
cFilAnt  := "X1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"100","('U1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "10"
cFilAnt  := "U1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"110","('Y1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "11"
cFilAnt  := "Y1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"120","('Z2')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "12"
cFilAnt  := "Z2"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"130","('T1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "13"
cFilAnt  := "T1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()



//-----------------------------------------------------------------------------------
//aAdd(aNovoGrupo,{"140","('S1')"})
//-----------------------------------------------------------------------------------
cEmpAnt  := "14"
cFilAnt  := "S1"
		
//Inicializa Ambiente
RPCSetType( 3 )
RpcSetEnv(cEmpAnt,cFilAnt)

//Ajusta dicionario da tabela RAX
fSX3_RAX()

//Ajusta dicionario da tabela RB6
fSX3_RB6()

//Ajusta dicionario da tabela SRE
fSX3_SRE()

//Ajusta dicionario da tabela RHG
fSX3_RHG()

//Ajusta indice da tabela EJZ
fSIX_EJZ()

//Ajusta indice da tabela ELB
fSIX_ELB()

//Ajusta indice da tabela SZ3
fSIX_SZ3()

//Apaga Dicionario de Tabela que existe indevidamente ou errado
fApagaDic()

//Ajusta pergunta da grupo GPEA281
fSX1_281()

//Ajusta campo da tabela RHH
fSX3_RHH()

//Ajusta campo da tabela RHT
fSX3_RHT()

//Ajusta indice da tabela SEV
fSIX_SEV()

//Ajusta Campos CARGO
fX3Cargo()

//Finaliza Ambiente
RpcClearEnv()

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_RAX()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_RAX()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela RAX
SX3->(DbSetOrder(1))
SX3->(DbSeek("RAX"))
While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "RAX"
    RecLock("SX3",.F.)
    SX3->X3_PROPRI := ""
    SX3->(MsUnLock())
	SX3->(DbSkip())
End

Return


//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_RB6()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_RB6()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela RB6
SX3->(DbSetOrder(2))
If SX3->(DbSeek("RB6_ATUAL"))
    RecLock("SX3",.F.)
    SX3->X3_PROPRI := ""
    SX3->(MsUnLock())
EndIf

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_SRE()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_SRE()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela SRE
SX3->(DbSetOrder(1))
SX3->(DbSeek("SRE"))
While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "SRE"
    If SubStr(SX3->X3_CAMPO,1,4) != "RE_X" .AND. SX3->X3_PROPRI == "U"
	    RecLock("SX3",.F.)
	    SX3->X3_PROPRI := ""
	    SX3->(MsUnLock())
	EndIf
	SX3->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_RHG()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_RHG()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela RAX
SX3->(DbSetOrder(1))
SX3->(DbSeek("RHG"))
While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "RHG"
    RecLock("SX3",.F.)
    SX3->X3_PROPRI := ""
    SX3->(MsUnLock())
	SX3->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSIX_EJZ()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSIX_EJZ()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela EJZ
SIX->(DbSetOrder(1))
SIX->(DbSeek("EJZ"))
While SIX->(!Eof()) .And. SIX->INDICE == "EJZ"
    RecLock("SIX",.F.)
    SIX->CHAVE     := StrTran(SIX->CHAVE    ,"EJZ_REGIST","EJZ_PROCES")
    SIX->DESCRICAO := StrTran(SIX->DESCRICAO,"EJZ_REGIST","Processo")
    SIX->DESCSPA   := StrTran(SIX->DESCSPA  ,"EJZ_REGIST","Processo")
    SIX->DESCENG   := StrTran(SIX->DESCENG  ,"EJZ_REGIST","Processo")
    SIX->(MsUnLock())
	SIX->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSIX_ELB()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSIX_ELB()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela ELB
SIX->(DbSetOrder(1))
SIX->(DbSeek("ELB"))
While SIX->(!Eof()) .And. SIX->INDICE == "ELB"
    RecLock("SIX",.F.)
    SIX->CHAVE     := StrTran(SIX->CHAVE    ,"ELB_TPPROC+","")
    SIX->DESCRICAO := StrTran(SIX->DESCRICAO,"ELB_TPPROC+","")
    SIX->DESCSPA   := StrTran(SIX->DESCSPA  ,"ELB_TPPROC+","")
    SIX->DESCENG   := StrTran(SIX->DESCENG  ,"ELB_TPPROC+","")
    SIX->(MsUnLock())
	SIX->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSIX_SZ3()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSIX_SZ3()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela SZ3
SIX->(DbSetOrder(1))
SIX->(DbSeek("SZ3"))
While SIX->(!Eof()) .And. SIX->INDICE == "SZ3"
    RecLock("SIX",.F.)
    SIX->PROPRI := "U"
    SIX->(MsUnLock())
	SIX->(DbSkip())
End

Return


//+-----------------------------------------------------------------------------------//
//|Funcao....: fApagaDic()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fApagaDic()
*-----------------------------------------------------------*
Local cTabDic := "TJG"

//Apaga tabela
SX2->(DbSetOrder(1))
SX2->(DbSeek(cTabDic))
While SX2->(!Eof()) .And. SX2->X2_CHAVE == cTabDic
    RecLock("SX2",.F.)
    SX2->(DbDelete())
    SX2->(MsUnLock())
	SX2->(DbSkip())
End

//Apaga campos
SX3->(DbSetOrder(1))
SX3->(DbSeek(cTabDic))
While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cTabDic
    RecLock("SX3",.F.)
    SX3->(DbDelete())
    SX3->(MsUnLock())
	SX3->(DbSkip())
End

//Apaga indices
SIX->(DbSetOrder(1))
SIX->(DbSeek(cTabDic))
While SIX->(!Eof()) .And. SIX->INDICE == cTabDic
    RecLock("SIX",.F.)
    SIX->(DbDelete())
    SIX->(MsUnLock())
	SIX->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX1_281()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX1_281()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela SZ3
SX1->(DbSetOrder(1))
SX1->(DbSeek("GPEA281"))
While SX1->(!Eof()) .And. ALLTRIM(SX1->X1_GRUPO) == "GPEA281"
    If SX1->X1_ORDEM == "03"
	    RecLock("SX1",.F.)
	    SX1->X1_TAMANHO := 20
	    SX1->(MsUnLock())
    EndIf
	SX1->(DbSkip())
End

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_RHH()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_RHH()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela RB6
SX3->(DbSetOrder(2))
If SX3->(DbSeek("RHH_CC"))
    RecLock("SX3",.F.)
    SX3->X3_TAMANHO := 14
    SX3->(MsUnLock())
EndIf

X31UpdTable("RHH")

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSX3_RHT()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSX3_RHT()
*-----------------------------------------------------------*

//Ajusta dicionario da tabela RB6
SX3->(DbSetOrder(2))
If SX3->(DbSeek("RHT_DFERVE"))
    RecLock("SX3",.F.)
    SX3->X3_TIPO := "N"
    SX3->(MsUnLock())
EndIf

X31UpdTable("RHT")

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fSIX_SEV()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 04 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fSIX_SEV()
*-----------------------------------------------------------*
Local cTabDic := "SEV"+"4"

//Apaga indices
SIX->(DbSetOrder(1))
If SIX->(DbSeek(cTabDic))
    RecLock("SIX",.F.)
    SIX->(DbDelete())
    SIX->(MsUnLock())
EndIf

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fX3Cargo()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 14 de Junho de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fX3Cargo(cEmpUpd)
*-----------------------------------------------------------*

Local x        := 0
Local aX3Cargo := {}
Local aX3Func  := {}

//Para tratar Update com erro no RetSqlName()
cEmpUpd := AllTrim(cEmpUpd)+"0"

//-------------------------------------------------------------
//Campos FUNCAO que serão ajustados!
//-------------------------------------------------------------
aAdd(aX3Func,{"AA1","AA1_FUNCAO"})
aAdd(aX3Func,{"ABQ","ABQ_FUNCAO"})
aAdd(aX3Func,{"ABO","ABO_FUNCAO"})
aAdd(aX3Func,{"RAL","RAL_FUNCAO"})
aAdd(aX3Func,{"RB2","RB2_FUNCAO"})
aAdd(aX3Func,{"RB4","RB4_FUNCAO"})
aAdd(aX3Func,{"RB5","RB5_FUNCAO"})
aAdd(aX3Func,{"RB7","RB7_FUNCAO"})
aAdd(aX3Func,{"RBD","RBD_FUNCAO"})
aAdd(aX3Func,{"RBE","RBE_FUNCAO"})
aAdd(aX3Func,{"RBT","RBT_FUNCAO"})
aAdd(aX3Func,{"RBU","RBU_FUNCAO"})
aAdd(aX3Func,{"RCL","RCL_FUNCAO"})
aAdd(aX3Func,{"SQG","QG_CODFUN" })
aAdd(aX3Func,{"SQS","QS_FUNCAO" })
aAdd(aX3Func,{"SR7","R7_FUNCAO" })
aAdd(aX3Func,{"SRJ","RJ_FUNCAO" })
aAdd(aX3Func,{"VAI","VAI_FUNCAO"})
aAdd(aX3Func,{"ZZV","ZZV_FUNCAO"})
aAdd(aX3Func,{"GYG","GYG_FUNCOD"})
aAdd(aX3Func,{"RIE","RIE_FUNCAO"})
aAdd(aX3Func,{"SV7","V7_FUNC"   })
aAdd(aX3Func,{"TE5","TE5_FUNCAO"})
aAdd(aX3Func,{"TFF","TFF_FUNCAO"})
aAdd(aX3Func,{"TI0","TI0_FUNCAO"})
aAdd(aX3Func,{"TJ1","TJ1_FUNC"  })
aAdd(aX3Func,{"TJ2","TJ2_FUNC"  })
aAdd(aX3Func,{"TJ5","TJ5_FUNC"  })
aAdd(aX3Func,{"TKM","TKM_FUNCAO"})
aAdd(aX3Func,{"TWN","TWN_FUNCAO"})

//-------------------------------------------------------------
//Campos CARGO que serão ajustados!
//-------------------------------------------------------------
aAdd(aX3Cargo,{"ABO","ABO_CARGO" })
aAdd(aX3Cargo,{"ABQ","ABQ_CARGO" })
aAdd(aX3Cargo,{"B07","B07_CARGO" })
aAdd(aX3Cargo,{"MA8","MA8_CARGO" })
aAdd(aX3Cargo,{"NT9","NT9_CCRGDP"})
aAdd(aX3Cargo,{"RA5","RA5_CARGO" })
aAdd(aX3Cargo,{"RA8","RA8_CARGO" })
aAdd(aX3Cargo,{"RB7","RB7_CARGO" })
aAdd(aX3Cargo,{"RBH","RBH_CARGO" })
aAdd(aX3Cargo,{"RBT","RBT_CARGO" })
aAdd(aX3Cargo,{"RBU","RBU_CARGO" })
aAdd(aX3Cargo,{"RC6","RC6_CARGO" })
aAdd(aX3Cargo,{"RCL","RCL_CARGO" })
aAdd(aX3Cargo,{"SA3","A3_CARGO"  })
aAdd(aX3Cargo,{"SQ3","Q3_CARGO"  })
aAdd(aX3Cargo,{"SQ4","Q4_CARGO"  })
aAdd(aX3Cargo,{"SQ5","Q5_CARGO"  })
aAdd(aX3Cargo,{"SQA","QA_CARGO"  })
aAdd(aX3Cargo,{"SR7","R7_CARGO"  })
aAdd(aX3Cargo,{"SRA","RA_CARGO"  })
aAdd(aX3Cargo,{"SRJ","RJ_CARGO"  })
aAdd(aX3Cargo,{"SUM","UM_CARGO"  })
aAdd(aX3Cargo,{"SV7","V7_CARG"   })
aAdd(aX3Cargo,{"ZZV","ZZV_CARGO" })
aAdd(aX3Cargo,{"RI6","RI6_CARGO" })
aAdd(aX3Cargo,{"RIE","RIE_CARGO" })
aAdd(aX3Cargo,{"TFF","TFF_CARGO" })
aAdd(aX3Cargo,{"TWN","TWN_CARGO" })

//-------------------------------------------------------------
//Ajustando dicionario
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	SX3->(DbSetOrder(2))
	If SX3->(DbSeek(aX3Func[x][2]))
		RecLock("SX3",.F.)
		SX3->X3_TAMANHO := 6
		SX3->X3_GRPSXG  := "901"
		SX3->(MsUnLock())
	EndIf
Next x

//Ajustando dicionario
For x:=1 To Len(aX3Cargo)
	SX3->(DbSetOrder(2))
	If SX3->(DbSeek(aX3Cargo[x][2]))
		RecLock("SX3",.F.)
		SX3->X3_TAMANHO := 6
		SX3->X3_GRPSXG  := "901"
		SX3->(MsUnLock())
	EndIf
Next x

//-------------------------------------------------------------
//Criar Campo ???_XXFUNC no SX3
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	fCriaCpoX3(aX3Func[x][1],"_XXFUNC","RB7_FUNCAO")
Next x

//Criar Campo ???_XXCARG no SX3
For x:=1 To Len(aX3Cargo)
	fCriaCpoX3(aX3Cargo[x][1],"_XXCARG","RB7_CARGO")
Next x

//-------------------------------------------------------------
//Efetivar ajustes do SX3 no Banco de Dados
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek(aX3Func[x][1]))
		X31UpdTable(aX3Func[x][1])
	EndIf
Next x

//Efetivar ajustes do SX3 no Banco de Dados
For x:=1 To Len(aX3Cargo)
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek(aX3Cargo[x][1]))
		X31UpdTable(aX3Cargo[x][1])
	EndIf
Next x


//-------------------------------------------------------------
//Apagando Backup antigo das tabelas caso exista
//-------------------------------------------------------------
TCSQLExec(" DROP TABLE AA1010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE ABO010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE ABQ010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE B07010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE MA8010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE NT9010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RA5010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RA8010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RAL010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RB2010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RB4010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RB5010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RB7010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RBD010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RBE010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RBH010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RBT010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RBU010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RC6010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE RCL010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SA3010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQ3010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQ4010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQ5010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQA010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQG010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SQS010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SR7010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SRA010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SRJ010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SUM010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SV7010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE VAI010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE ZZV010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SRV010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SRD010_BKP_2018_P11 ")
TCSQLExec(" DROP TABLE SRH010_BKP_2018_P11 ")

//-------------------------------------------------------------
//Popular campos _XXFUNC com as informações dos campos PADRAO
//-------------------------------------------------------------
For x:=1 To Len(aX3Func)
	fExecUpdBD(aX3Func[x][1],aX3Func[x][2],"_XXFUNC",cEmpUpd,1)
Next x

//Popular campos _XXCARG com as informações dos campos PADRAO
For x:=1 To Len(aX3Cargo)
	fExecUpdBD(aX3Cargo[x][1],aX3Cargo[x][2],"_XXCARG",cEmpUpd,1)
Next x

//-------------------------------------------------------------
//Fazendo Backup das tabelas após ajuste
//-------------------------------------------------------------
TCSQLExec(" CREATE TABLE AA1010_BKP_2018_P11 AS ( SELECT * FROM AA1010 ) ")
TCSQLExec(" CREATE TABLE ABO010_BKP_2018_P11 AS ( SELECT * FROM ABO010 ) ")
TCSQLExec(" CREATE TABLE ABQ010_BKP_2018_P11 AS ( SELECT * FROM ABQ010 ) ")
TCSQLExec(" CREATE TABLE B07010_BKP_2018_P11 AS ( SELECT * FROM B07010 ) ")
TCSQLExec(" CREATE TABLE MA8010_BKP_2018_P11 AS ( SELECT * FROM MA8010 ) ")
TCSQLExec(" CREATE TABLE NT9010_BKP_2018_P11 AS ( SELECT * FROM NT9010 ) ")
TCSQLExec(" CREATE TABLE RA5010_BKP_2018_P11 AS ( SELECT * FROM RA5010 ) ")
TCSQLExec(" CREATE TABLE RA8010_BKP_2018_P11 AS ( SELECT * FROM RA8010 ) ")
TCSQLExec(" CREATE TABLE RAL010_BKP_2018_P11 AS ( SELECT * FROM RAL010 ) ")
TCSQLExec(" CREATE TABLE RB2010_BKP_2018_P11 AS ( SELECT * FROM RB2010 ) ")
TCSQLExec(" CREATE TABLE RB4010_BKP_2018_P11 AS ( SELECT * FROM RB4010 ) ")
TCSQLExec(" CREATE TABLE RB5010_BKP_2018_P11 AS ( SELECT * FROM RB5010 ) ")
TCSQLExec(" CREATE TABLE RB7010_BKP_2018_P11 AS ( SELECT * FROM RB7010 ) ")
TCSQLExec(" CREATE TABLE RBD010_BKP_2018_P11 AS ( SELECT * FROM RBD010 ) ")
TCSQLExec(" CREATE TABLE RBE010_BKP_2018_P11 AS ( SELECT * FROM RBE010 ) ")
TCSQLExec(" CREATE TABLE RBH010_BKP_2018_P11 AS ( SELECT * FROM RBH010 ) ")
TCSQLExec(" CREATE TABLE RBT010_BKP_2018_P11 AS ( SELECT * FROM RBT010 ) ")
TCSQLExec(" CREATE TABLE RBU010_BKP_2018_P11 AS ( SELECT * FROM RBU010 ) ")
TCSQLExec(" CREATE TABLE RC6010_BKP_2018_P11 AS ( SELECT * FROM RC6010 ) ")
TCSQLExec(" CREATE TABLE RCL010_BKP_2018_P11 AS ( SELECT * FROM RCL010 ) ")
TCSQLExec(" CREATE TABLE SA3010_BKP_2018_P11 AS ( SELECT * FROM SA3010 ) ")
TCSQLExec(" CREATE TABLE SQ3010_BKP_2018_P11 AS ( SELECT * FROM SQ3010 ) ")
TCSQLExec(" CREATE TABLE SQ4010_BKP_2018_P11 AS ( SELECT * FROM SQ4010 ) ")
TCSQLExec(" CREATE TABLE SQ5010_BKP_2018_P11 AS ( SELECT * FROM SQ5010 ) ")
TCSQLExec(" CREATE TABLE SQA010_BKP_2018_P11 AS ( SELECT * FROM SQA010 ) ")
TCSQLExec(" CREATE TABLE SQG010_BKP_2018_P11 AS ( SELECT * FROM SQG010 ) ")
TCSQLExec(" CREATE TABLE SQS010_BKP_2018_P11 AS ( SELECT * FROM SQS010 ) ")
TCSQLExec(" CREATE TABLE SR7010_BKP_2018_P11 AS ( SELECT * FROM SR7010 ) ")
TCSQLExec(" CREATE TABLE SRA010_BKP_2018_P11 AS ( SELECT * FROM SRA010 ) ")
TCSQLExec(" CREATE TABLE SRJ010_BKP_2018_P11 AS ( SELECT * FROM SRJ010 ) ")
TCSQLExec(" CREATE TABLE SUM010_BKP_2018_P11 AS ( SELECT * FROM SUM010 ) ")
TCSQLExec(" CREATE TABLE SV7010_BKP_2018_P11 AS ( SELECT * FROM SV7010 ) ")
TCSQLExec(" CREATE TABLE VAI010_BKP_2018_P11 AS ( SELECT * FROM VAI010 ) ")
TCSQLExec(" CREATE TABLE ZZV010_BKP_2018_P11 AS ( SELECT * FROM ZZV010 ) ")
TCSQLExec(" CREATE TABLE SRV010_BKP_2018_P11 AS ( SELECT * FROM SRV010 ) ")
TCSQLExec(" CREATE TABLE SRD010_BKP_2018_P11 AS ( SELECT * FROM SRD010 ) ")
TCSQLExec(" CREATE TABLE SRH010_BKP_2018_P11 AS ( SELECT * FROM SRH010 ) ")

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fCriaCpoX3()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 18 de junho de 2018, 09:00
//|Descricao.: Essa rotina cria o campo no SX3
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fCriaCpoX3(cCadAlias,cNewCampo,cCpoCopia)
*-----------------------------------------------------------*

Local cCadCampo := IIf(SubStr(cCadAlias,1,1)=="S",SubStr(cCadAlias,2,2),cCadAlias) + cNewCampo
Local aX3Struct := SX3->(DbStruct())
Local aX3Conteu := {}
Local cNewOrdem := "01"
Local lExistAls := .F.

//Carrega Conteudo do Campo que será copia
SX3->(DbSetOrder(2))
SX3->(DbSeek(cCpoCopia))
For x:=1 To Len(aX3Struct)
	aAdd(aX3Conteu,{"SX3->"+AllTrim(aX3Struct[x][1]),&("SX3->"+AllTrim(aX3Struct[x][1])) } )
Next x

//Verificar qual é a ultima order do ALIAS
SX3->(DbSetOrder(1))
SX3->(DbSeek(cCadAlias))
While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cCadAlias
	lExistAls := .T.
	cNewOrdem := SX3->X3_ORDEM
	SX3->(DbSkip())
End
cNewOrdem := Soma1(cNewOrdem)

//Copia Conteudo do Campo ajustando apenas 
SX3->(DbSetOrder(2))
If lExistAls .And. SX3->(!DbSeek(cCadCampo))
	Reclock("SX3",.T.)
	For x:=1 To Len(aX3Conteu)
		&(aX3Conteu[x][1]) := aX3Conteu[x][2]
		SX3->X3_CAMPO := cCadCampo
	Next x
	SX3->X3_ARQUIVO := cCadAlias
	SX3->X3_CAMPO   := cCadCampo
	SX3->X3_ORDEM   := cNewOrdem
	SX3->X3_CHKSQL  := " "
	SX3->X3_VALID   := " "
	SX3->(MsunLock())
EndIf

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fExecUpdBD()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 09 de abril de 2018, 09:00
//|Descricao.: Essa rotina popula conteudo dos campos CARGO e FUNCAO que P12 Trunca
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fExecUpdBD(cUpdAlias,cUpdCpOrig,cNewCampo,cEmpUpd,nOpc)
*-----------------------------------------------------------*

Local cUpdCpDest := IIf(SubStr(cUpdAlias,1,1)=="S",SubStr(cUpdAlias,2,2),cUpdAlias) + cNewCampo
Local cUpdQuery  := ""

//Faz backup
If nOpc == 1
	cUpdQuery  := " UPDATE "+cUpdAlias+cEmpUpd+" SET "+cUpdCpDest+" = "+cUpdCpOrig+" "
EndIf

//Restaura backup
If nOpc == 2
	cUpdQuery  := " UPDATE "+cUpdAlias+cEmpUpd+" SET "+cUpdCpOrig+" = "+cUpdCpDest+" "
EndIf

//Só executa se campo existe
SX3->(DbSetOrder(2))
If SX3->(DbSeek(cUpdCpDest))
	TCSQLExec(cUpdQuery)
EndIf

Return


//+-----------------------------------------------------------------------------------//
//|Funcao....: fDuplSRH()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 09 de abril de 2018, 09:00
//|Descricao.: Essa rotina ajustar as inconsistencias acusadas na migração para a P12
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fDuplSRH(cEmpUpd)
*-----------------------------------------------------------*
Local cQryUpd := " "
Local cTcErro := " "
Local nRet    := 0

For x:=1 To 2
	//-----------------------------------------------------------------------------------------------
	// Update 01 - GpeConv - Validação Inicial
	//-----------------------------------------------------------------------------------------------
	cQryUpd := "     SELECT XX_RECNO FROM "
	cQryUpd += "     ( "
	cQryUpd += "         SELECT RH_FILIAL, RH_MAT, RH_DATABAS, RH_DTRECIB, COUNT(*) QTD, MIN(R_E_C_N_O_) XX_RECNO "
	cQryUpd += "         FROM SRH"+cEmpUpd+" "
	cQryUpd += "         WHERE D_E_L_E_T_ <> '*' "
	cQryUpd += "         GROUP BY RH_FILIAL, RH_MAT, RH_DATABAS, RH_DTRECIB "
	cQryUpd += "     ) TRB WHERE QTD > 1 "
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	
	//Monta Alias
	TcQuery cQryUpd ALIAS "TEMP" NEW
	
	//Formata campo Data
	TcSetField("TEMP","RH_DTRECIB","D",8)
	
	//Posiciona no 1o registro
	TEMP->(DbGoTop())
	
	//Atualiza registros
	While TEMP->(!Eof())
		SRH->(DbGoTo(TEMP->XX_RECNO))
		If TEMP->XX_RECNO == SRH->(Recno())
			RecLock("SRH",.F.)
			SRH->RH_DTRECIB := SRH->RH_DTRECIB+1
			SRH->(MsUnLock())
		EndIf
		TEMP->(DbSkip())
	End
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	//-----------------------------------------------------------------------------------------------
Next x


For x:=1 To 5
	//-----------------------------------------------------------------------------------------------
	// Update 02 - GpeConv - Item 15 = Férias
	//-----------------------------------------------------------------------------------------------
	cQryUpd := " SELECT XX_RECNO "
	cQryUpd += "   FROM (SELECT RH_FILIAL,RH_MAT,RH_DTRECIB,COUNT(*) QTD, MIN(R_E_C_N_O_) XX_RECNO "
	cQryUpd += "           FROM SRH"+cEmpUpd+" "
	cQryUpd += "          WHERE D_E_L_E_T_ = ' ' "
	cQryUpd += "            AND RH_DTRECIB <> ' ' "
	cQryUpd += "          GROUP BY RH_FILIAL, RH_MAT, RH_DTRECIB) TRB "
	cQryUpd += "  WHERE QTD > 1 "
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	
	//Monta Alias
	TcQuery cQryUpd ALIAS "TEMP" NEW
	
	//Formata campo Data
	TcSetField("TEMP","RH_DTRECIB","D",8)
	
	//Posiciona no 1o registro
	TEMP->(DbGoTop())
	
	//Atualiza registros
	While TEMP->(!Eof())
		SRH->(DbGoTo(TEMP->XX_RECNO))
		If TEMP->XX_RECNO == SRH->(Recno())
			RecLock("SRH",.F.)
			SRH->RH_DTRECIB := SRH->RH_DTRECIB+1
			SRH->(MsUnLock())
		EndIf
		TEMP->(DbSkip())
	End
	
	//Finaliza ALIAS caso esteja aberto
	If Select("TEMP") <> 0
		TEMP->(DbCloseArea())
	EndIf
	//-----------------------------------------------------------------------------------------------
Next x

Return()

//+-----------------------------------------------------------------------------------//
//|Funcao....: UpdGpCnv()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 10 de maio de 2018, 09:00
//|Descricao.: Essa rotina irá ajustar os registros da tabela SRD com base na procedure
//|          : executada no GPECONV, a procedure é: CONVUPDSRV_XX()
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function UpdGpCnv()
*-----------------------------------------------------------*
Local x          :=  0
Local aNovoGrupo := {}
Local cEmpUpd    := ""
Local lDelSRD    := .F.
Local cHrProc    := DtoC(Date())+" - "+Time()+" ate "
//-----------------------------------------------------------------------------------
//Empresas
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"010","('11')"})
//aAdd(aNovoGrupo,{"020","('31')"})
//aAdd(aNovoGrupo,{"030","('41')"})
//aAdd(aNovoGrupo,{"040","('51')"})
//aAdd(aNovoGrupo,{"050","('61')"})
//aAdd(aNovoGrupo,{"060","('Z1')"})
//aAdd(aNovoGrupo,{"070","('Z3')"})
//aAdd(aNovoGrupo,{"080","('W1')"})
//aAdd(aNovoGrupo,{"090","('X1')"})
//aAdd(aNovoGrupo,{"100","('U1')"})
//aAdd(aNovoGrupo,{"110","('Y1')"})
//aAdd(aNovoGrupo,{"120","('Z2')"})
//aAdd(aNovoGrupo,{"130","('T1')"})
//aAdd(aNovoGrupo,{"140","('S1')"})
//-----------------------------------------------------------------------------------

//Começar fazendo loop na nova definição dos grupos
For x:=1 To Len(aNovoGrupo)

	cEmpAnt  := SubStr(aNovoGrupo[x][01],1,2)
	cFilAnt  := SubStr(aNovoGrupo[x][02],3,2)
	cEmpUpd  := aNovoGrupo[x][01]
	
	//Inicializa Ambiente
	RPCSetType( 3 )	//Não consome licensa de uso
	RpcSetEnv(cEmpAnt,cFilAnt)


	//-------------------------------------------------------------
	//Cadastra ID na tabela SRD
	//-------------------------------------------------------------
	SRV->(DbSetOrder(1))
	If SRV->(DbSeek(xFilial("SRV")+"267"))
		If Empty(SRV->RV_CODFOL)
			RecLock("SRV",.F.)
			SRV->RV_CODFOL := "0103"
			SRV->(MsUnLock())
		EndIf
	EndIf
	SRV->(DbSetOrder(1))
	If SRV->(DbSeek(xFilial("SRV")+"275"))
		If Empty(SRV->RV_CODFOL)
			RecLock("SRV",.F.)
			SRV->RV_CODFOL := "0891"
			SRV->(MsUnLock())
		EndIf
	EndIf
	SRV->(DbSetOrder(1))
	If SRV->(DbSeek(xFilial("SRV")+"276"))
		If Empty(SRV->RV_CODFOL)
			RecLock("SRV",.F.)
			SRV->RV_CODFOL := "0927"
			SRV->(MsUnLock())
		EndIf
	EndIf
	
	//-------------------------------------------------------------
	//Apaga Registros da tabela SRD, pois não existe SRA dessa Matricula
	//-------------------------------------------------------------
	lDelSRD := .F.
	SRD->(DbSetOrder(1))
	SRD->(DbSeek("62"+"261327"))
	While SRD->(!Eof()) .And. SRD->RD_FILIAL == "62" .And. SRD->RD_MAT == "261327"
		lDelSRD := .T.
	
		RecLock("SRD",.F.)
		SRD->(DbDelete())
		SRD->(MsUnLock())
			
		SRD->(DbSkip())
	End
	SRD->(DbSetOrder(1))
	SRD->(DbSeek("68"+"587505"))
	While SRD->(!Eof()) .And. SRD->RD_FILIAL == "68" .And. SRD->RD_MAT == "587505"
		lDelSRD := .T.
	
		RecLock("SRD",.F.)
		SRD->(DbDelete())
		SRD->(MsUnLock())
			
		SRD->(DbSkip())
	End
	//Só executa pack se registros foram deletados
	If lDelSRD
		SRD->(DbCloseArea())
		TCSQLExec(" DELETE SRD"+cEmpUpd+" WHERE D_E_L_E_T_ = '*' ")
		DbSelectArea("SRD")
		TcRefresh("SRD"+cEmpUpd)
		TcRefresh("SRD")    
		DbCloseArea()
	EndIf
	
	//-------------------------------------------------------------
	//Corrige duplicidade dos registros da tabela SRH
	//-------------------------------------------------------------
	fDuplSRH(cEmpUpd)

    //Atualiza campo RD_SEQ para evitar duplicidade de registros
	fDuplSRD(cEmpUpd)

	//Finaliza Ambiente
	RpcClearEnv()

Next x
//-----------------------------------------------------------------------------------

cHrProc += Time()
ConOut(cHrProc)
SimNao("Processo finalizado!!!"+Chr(13)+Chr(10)+cHrProc)

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fDuplSRD()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 25 de junho de 2018, 09:00
//|Descricao.: 
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fDuplSRD(cEmpUpd)
*-----------------------------------------------------------*
Local cQuery    := ""
Local cKeyOld   := ""
Local cNewSeq   := ""
Local cFiltroFil:= "" 

//--------------------------------------------------------------------------------------------------------------------------------
//Query 01 - Exexutando emulador GPECONV
//--------------------------------------------------------------------------------------------------------------------------------
cQuery := fQry1SRD(cEmpUpd)

//Finaliza ALIAS caso esteja aberto
If Select("TMP1") <> 0 ; TMP1->(DbCloseArea()) ; EndIf

//Monta Alias
TcQuery cQuery ALIAS "TMP1" NEW

//Posiciona no 1o registro
TMP1->(DbGoTop())
While TMP1->(!Eof())

	//---------------------------------------
    //Posiciona no Recno e Atualiza        01
	//---------------------------------------
    cNewSeq   := ""
	Do Case
		Case TMP1->NEW_SEQ == 1
			cNewSeq := "T"

		Case TMP1->NEW_SEQ == 2
			cNewSeq := "U"

		Case TMP1->NEW_SEQ == 3
			cNewSeq := "X"

		Case TMP1->NEW_SEQ == 4
			cNewSeq := "Y"

		Case TMP1->NEW_SEQ == 5
			cNewSeq := "Z"

	EndCase

	//---------------------------------------
    //Atualiza o campo SEQ e SEMANA
	//---------------------------------------
    SRD->(DbGoTo(TMP1->RD_RECNO))
	//---------------------------------------
    RecLock("SRD",.F.)
	SRD->RD_SEQ    := cNewSeq
	SRD->RD_SEMANA := fTrataSem(SRD->RD_SEMANA)
    SRD->(MsUnLock())
	//---------------------------------------

	//---------------------------------------
	TMP1->(DbSkip())
End
//Finaliza ALIAS caso esteja aberto
If Select("TMP1") <> 0 ; TMP1->(DbCloseArea()) ; EndIf
//--------------------------------------------------------------------------------------------------------------------------------




//--------------------------------------------------------------------------------------------------------------------------------
//Query 02 - Exexutando Verificação de Legado
//--------------------------------------------------------------------------------------------------------------------------------
cQuery := fQry2SRD(cEmpUpd)

//Finaliza ALIAS caso esteja aberto
If Select("TMP2") <> 0 ; TMP2->(DbCloseArea()) ; EndIf

//Monta Alias
TcQuery cQuery ALIAS "TMP2" NEW

//Posiciona no 1o registro
cKeyOld := ""
cNewSeq := ""
TMP2->(DbGoTop())
While TMP2->(!Eof())

	If cKeyOld != TMP2->RD_KEYOLD
		cNewSeq := "A"
	Else
		cNewSeq := Soma1(cNewSeq)
	EndIf

	//---------------------------------------
    //Atualiza o campo SEQ e SEMANA
	//---------------------------------------
    SRD->(DbGoTo(TMP2->RD_RECNO))
	//---------------------------------------
    RecLock("SRD",.F.)
	SRD->RD_SEQ := cNewSeq
	SRD->RD_SEMANA := fTrataSem(SRD->RD_SEMANA)
    SRD->(MsUnLock())

	//---------------------------------------
	cKeyOld := TMP2->RD_KEYOLD
	//---------------------------------------
	TMP2->(DbSkip())
End
//Finaliza ALIAS caso esteja aberto
If Select("TMP2") <> 0 ; TMP2->(DbCloseArea()) ; EndIf
//--------------------------------------------------------------------------------------------------------------------------------


//cFiltroFil := " AND RD_FILIAL = '31' " //TESTE
//--------------------------------------------------------------------------------------------------------------------------------
//Move todas as sequencias NÃO duplicadas para SEQ = " "
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = ' ' WHERE RD_SEQ IN ('1','2','3','4','5','6','7','8','9') "+cFiltroFil)
//--------------------------------------------------------------------------------------------------------------------------------
//Na execução do GPECONV pode virar 2 - Tratativa Query 01
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '1' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'T' "+cFiltroFil)
//Na execução do GPECONV pode virar 4 - Tratativa Query 01
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '3' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'U' "+cFiltroFil)
//Na execução do GPECONV pode virar 6 - Tratativa Query 01
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '5' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'X' "+cFiltroFil)
//Na execução do GPECONV pode virar 8 - Tratativa Query 01
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '7' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'Y' "+cFiltroFil)
//Na execução do GPECONV pode virar 0 - Tratativa Query 01
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '9' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'Z' "+cFiltroFil)


//--------------------------------------------------------------------------------------------------------------------------------
//Na execução do GPECONV pode virar 1 - Tratativa Query 02
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '0' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'A' "+cFiltroFil)
//Na execução do GPECONV pode virar 3 - Tratativa Query 02
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '2' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'B' "+cFiltroFil)
//Na execução do GPECONV pode virar 5 - Tratativa Query 02
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '4' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'C' "+cFiltroFil)
//Na execução do GPECONV pode virar 7 - Tratativa Query 02
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '6' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'D' "+cFiltroFil)
//Na execução do GPECONV pode virar 9 - Tratativa Query 02
TcSqlExec(" UPDATE SRD"+cEmpUpd+" SET RD_SEQ = '8' WHERE D_E_L_E_T_ = ' ' AND RD_SEQ = 'E' "+cFiltroFil)
//--------------------------------------------------------------------------------------------------------------------------------


Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fQry1SRD()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 27 de maio de 2018, 09:00
//|Descricao.: 
//|          : 
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fTrataSem(cVerSem)
*-----------------------------------------------------------*
Local cRet := ""

Do Case
	Case Empty(cVerSem)
		cRet := "01"

	Case AllTrim(cVerSem) == "00"
		cRet := "01"

	Case AllTrim(cVerSem) == "0"
		cRet := "01"

	Case AllTrim(cVerSem) == "1"
		cRet := "01"

	Case !Empty(cVerSem) .And. Len(AllTrim(cVerSem)) == 2
		cRet := cVerSem

	OtherWise
		cRet := "01"

EndCase

Return(cRet)

//+-----------------------------------------------------------------------------------//
//|Funcao....: fQry1SRD()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 27 de maio de 2018, 09:00
//|Descricao.: 
//|          : 
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fQry1SRD(cEmpUpd)
*-----------------------------------------------------------*

Local cQuery    := ""
Local cQbra     := Chr(13)+Chr(10)

Local cPDADIANT := "'"+fGetCodFol("0007")+"'"
Local cPDARRAD  := "'"+fGetCodFol("0008")+"'"
Local cPD151    := "'"+fGetCodFol("0151")+"'"
Local cPD152    := "'"+fGetCodFol("0152")+"'"
Local cPD300    := "'"+fGetCodFol("0300")+"'"
Local cPD0022   := "'"+fGetCodFol("0022")+"'"
Local cPD0108   := "'"+fGetCodFol("0108")+"'"
Local cPD0109   := "'"+fGetCodFol("0109")+"'"
Local cPD0678   := "'"+fGetCodFol("0678")+"'"
Local cPD213    := "'"+fGetCodFol("0024")+"'"
Local cPDDESC13 := "'"+fGetCodFol("0023")+"'"

//------------------------------------------------------------------------------------
// Query para ajustar o campo RD_SEQ
//------------------------------------------------------------------------------------
cQuery := cQbra+" SELECT SRD_GRUPO, "
cQuery += cQbra+"        RD_RECNO, "
cQuery += cQbra+"        REC_LISTA, "
cQuery += cQbra+"        ROW_NUMBER() OVER(PARTITION BY SRD_GRUPO ORDER BY SRD_GRUPO, REC_LISTA) AS NEW_SEQ "
cQuery += cQbra+"   FROM (SELECT SRD_GRUPO, "
cQuery += cQbra+"                RD_RECNO, "
cQuery += cQbra+"                LISTAGG(RD_RECNO, ' / ') WITHIN GROUP(ORDER BY SRD_GRUPO) OVER(PARTITION BY SRD_GRUPO) AS REC_LISTA "
cQuery += cQbra+"           FROM (SELECT RD_RECNO, "
cQuery += cQbra+"                        RD_FILIAL || RD_MAT || RD_CC || RD_ITEM || RD_CLVL || "
cQuery += cQbra+"                        RD_DATARQ || RD_PD || RD_CONVOC || NEW_SEQ || "
cQuery += cQbra+"                        NEW_PERIODO || NEW_SEMANA || NEW_ROTEIR || NEW_DTREF AS SRD_GRUPO "
cQuery += cQbra+"                   FROM (SELECT RD_FILIAL, "
cQuery += cQbra+"                                RD_MAT, "
cQuery += cQbra+"                                RD_CC, "
cQuery += cQbra+"                                RD_ITEM, "
cQuery += cQbra+"                                RD_CLVL, "
cQuery += cQbra+"                                RD_DATARQ, "
cQuery += cQbra+"                                RD_PD, "
cQuery += cQbra+"                                RD_CONVOC, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_MES < '13' "
cQuery += cQbra+"                          THEN RD_DATARQ "
cQuery += cQbra+"                          ELSE CONCAT(SUBSTR(RD_DATARQ, 1, 4), '12') "
cQuery += cQbra+"                        END AS NEW_PERIODO, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        ' ' AS NEW_SEQ, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_ROTEIR <> '   ' "
cQuery += cQbra+"                          THEN RD_ROTEIR "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_TIPO2 = 'A' "
cQuery += cQbra+"                               AND RD_PD NOT IN ("+cPDADIANT+", "+cPDARRAD+") "
cQuery += cQbra+"                               AND RD_SEMANA = '  ' "
cQuery += cQbra+"                          THEN 'ADI' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN (( RD_MES < '13' AND  RD_PD IN ("+cPD151+", "+cPD152+", "+cPD300+")) "
cQuery += cQbra+"                                  OR "
cQuery += cQbra+"                                ( RD_TIPO2 = 'A' AND RD_SEMANA = '01')) "
cQuery += cQbra+"                          THEN 'PLR' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_MES < '13' "
cQuery += cQbra+"                               AND RD_PD IN ("+cPD0022+", "+cPD0108+", "+cPD0109+", "+cPD0678+") "
cQuery += cQbra+"                               AND (SELECT COUNT(*) "
cQuery += cQbra+"                                      FROM SRD010 SRDAUX "
cQuery += cQbra+"                                     WHERE SRDAUX.RD_FILIAL  = RA_FILIAL "
cQuery += cQbra+"                                       AND SRDAUX.RD_MAT     = RA_MAT "
cQuery += cQbra+"                                       AND SRDAUX.RD_PD      = "+cPDDESC13+" "
cQuery += cQbra+"                                       AND SRDAUX.D_E_L_E_T_ = ' ') > 0 "
cQuery += cQbra+"                          THEN '131' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_PD = "+cPD213+" OR (RD_TIPO2 = 'S' AND RD_MES = '13') "
cQuery += cQbra+"                          THEN '132' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RA_CATFUNC IN ('P', 'A') "
cQuery += cQbra+"                          THEN 'AUT' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          ELSE 'FOL' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                        END AS NEW_ROTEIR, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_MES < '13' AND RD_PD IN ("+cPD151+", "+cPD152+", "+cPD300+") "
cQuery += cQbra+"                          THEN CONCAT(SUBSTR(RD_DTREF, 1, 4), '0101') "
cQuery += cQbra+"                          ELSE RD_DTREF "
cQuery += cQbra+"                        END AS NEW_DTREF, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_SEMANA = '  ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '0 ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '1 ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '00' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          ELSE RD_SEMANA "
cQuery += cQbra+"                        END AS NEW_SEMANA, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        RA_PROCES AS NEW_PROCES, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        SRD.R_E_C_N_O_ AS RD_RECNO "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                   FROM SRD"+cEmpUpd+" SRD "
cQuery += cQbra+"                  INNER JOIN SRA"+cEmpUpd+" SRA ON SRA.D_E_L_E_T_ = ' ' "
cQuery += cQbra+"                                               AND SRA.RA_FILIAL  = RD_FILIAL "
cQuery += cQbra+"                                               AND SRA.RA_MAT     = RD_MAT "
cQuery += cQbra+"                  WHERE SRD.D_E_L_E_T_ = ' ' "
//cQuery += cQbra+"                    AND SRA.RA_FILIAL  = '31' " //TESTE
cQuery += cQbra+"                            AND SRA.RA_PROCES <> ' ') TRB) TRB2) TRB3 "
cQuery += cQbra+"  WHERE REC_LISTA LIKE '%/%' "
cQuery += cQbra+"  ORDER BY SRD_GRUPO, REC_LISTA "

/*
//------------------------------------------------------------------------------------
// Query para ajustar o campo RD_SEQ
//------------------------------------------------------------------------------------
cQuery := cQbra+" SELECT * "
cQuery += cQbra+"   FROM (SELECT RD_FILIAL, "
cQuery += cQbra+"                RD_MAT, "
cQuery += cQbra+"                RD_CC, "
cQuery += cQbra+"                RD_ITEM, "
cQuery += cQbra+"                RD_CLVL, "
cQuery += cQbra+"                RD_DATARQ, "
cQuery += cQbra+"                RD_PD, "
cQuery += cQbra+"                RD_CONVOC, "
cQuery += cQbra+"                NEW_SEQ, "
cQuery += cQbra+"                NEW_PERIODO, "
cQuery += cQbra+"                NEW_SEMANA, "
cQuery += cQbra+"                NEW_ROTEIR, "
cQuery += cQbra+"                NEW_DTREF, "
cQuery += cQbra+"                MIN(RD_RECNO) MIN_RECNO, "
cQuery += cQbra+"                MAX(RD_RECNO) MAX_RECNO, "
cQuery += cQbra+"                COUNT(*) QTD "
cQuery += cQbra+"           FROM (SELECT RD_FILIAL, "
cQuery += cQbra+"                        RD_MAT, "
cQuery += cQbra+"                        RD_CC, "
cQuery += cQbra+"                        RD_ITEM, "
cQuery += cQbra+"                        RD_CLVL, "
cQuery += cQbra+"                        RD_DATARQ, "
cQuery += cQbra+"                        RD_PD, "
cQuery += cQbra+"                        RD_CONVOC, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_MES < '13' "
cQuery += cQbra+"                          THEN RD_DATARQ "
cQuery += cQbra+"                          ELSE CONCAT(SUBSTR(RD_DATARQ, 1, 4), '12') "
cQuery += cQbra+"                        END AS NEW_PERIODO, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        ' ' AS NEW_SEQ, "
//cQuery += cQbra+"                        CASE "
//cQuery += cQbra+"                          WHEN RD_SEQ = '9' "
//cQuery += cQbra+"                          THEN ' ' "
//                                         ----------------------------------------------------------------------------------------
//cQuery += cQbra+"                          WHEN RD_ROTEIR = '   ' AND RD_SEMANA <> '  ' AND RA_TIPOPGT <> 'S' "
//cQuery += cQbra+"                          THEN CAST(((CAST((REPLACE(RD_SEQ, ' ', '0')) AS INT) + 1)) AS CHAR) "
//                                         ----------------------------------------------------------------------------------------
//cQuery += cQbra+"                          ELSE RD_SEQ "
//cQuery += cQbra+"                        END AS NEW_SEQ, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_ROTEIR <> '   ' "
cQuery += cQbra+"                          THEN RD_ROTEIR "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_TIPO2 = 'A' "
cQuery += cQbra+"                               AND RD_PD NOT IN ("+cPDADIANT+", "+cPDARRAD+") "
cQuery += cQbra+"                               AND RD_SEMANA = '  ' "
cQuery += cQbra+"                          THEN 'ADI' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN (( RD_MES < '13' AND  RD_PD IN ("+cPD151+", "+cPD152+", "+cPD300+")) "
cQuery += cQbra+"                                  OR "
cQuery += cQbra+"                                ( RD_TIPO2 = 'A' AND RD_SEMANA = '01')) "
cQuery += cQbra+"                          THEN 'PLR' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_MES < '13' "
cQuery += cQbra+"                               AND RD_PD IN ("+cPD0022+", "+cPD0108+", "+cPD0109+", "+cPD0678+") "
cQuery += cQbra+"                               AND (SELECT COUNT(*) "
cQuery += cQbra+"                                      FROM SRD010 SRDAUX "
cQuery += cQbra+"                                     WHERE SRDAUX.RD_FILIAL  = RA_FILIAL "
cQuery += cQbra+"                                       AND SRDAUX.RD_MAT     = RA_MAT "
cQuery += cQbra+"                                       AND SRDAUX.RD_PD      = "+cPDDESC13+" "
cQuery += cQbra+"                                       AND SRDAUX.D_E_L_E_T_ = ' ') > 0 "
cQuery += cQbra+"                          THEN '131' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_PD = "+cPD213+" OR (RD_TIPO2 = 'S' AND RD_MES = '13') "
cQuery += cQbra+"                          THEN '132' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RA_CATFUNC IN ('P', 'A') "
cQuery += cQbra+"                          THEN 'AUT' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          ELSE 'FOL' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                        END AS NEW_ROTEIR, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_MES < '13' AND RD_PD IN ("+cPD151+", "+cPD152+", "+cPD300+") "
cQuery += cQbra+"                          THEN CONCAT(SUBSTR(RD_DTREF, 1, 4), '0101') "
cQuery += cQbra+"                          ELSE RD_DTREF "
cQuery += cQbra+"                        END AS NEW_DTREF, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        CASE "
cQuery += cQbra+"                          WHEN RD_SEMANA = '  ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '0 ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '1 ' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          WHEN RD_SEMANA = '00' "
cQuery += cQbra+"                          THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                          ELSE RD_SEMANA "
cQuery += cQbra+"                        END AS NEW_SEMANA, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        RA_PROCES AS NEW_PROCES, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                        SRD.R_E_C_N_O_ AS RD_RECNO "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                   FROM SRD"+cEmpUpd+" SRD "
cQuery += cQbra+"                  INNER JOIN SRA"+cEmpUpd+" SRA ON SRA.D_E_L_E_T_ = ' ' "
cQuery += cQbra+"                                               AND SRA.RA_FILIAL  = RD_FILIAL "
cQuery += cQbra+"                                               AND SRA.RA_MAT     = RD_MAT "
cQuery += cQbra+"                  WHERE SRD.D_E_L_E_T_ = ' ' "
//cQuery += cQbra+"                    AND SRA.RA_FILIAL  = '31' " //TESTE
cQuery += cQbra+"                    AND SRA.RA_PROCES <> ' ') TRB "
cQuery += cQbra+"          GROUP BY RD_FILIAL, "
cQuery += cQbra+"                   RD_MAT, "
cQuery += cQbra+"                   RD_CC, "
cQuery += cQbra+"                   RD_ITEM, "
cQuery += cQbra+"                   RD_CLVL, "
cQuery += cQbra+"                   RD_DATARQ, "
cQuery += cQbra+"                   RD_PD, "
cQuery += cQbra+"                   RD_CONVOC, "
cQuery += cQbra+"                   NEW_SEQ, "
cQuery += cQbra+"                   NEW_PERIODO, "
cQuery += cQbra+"                   NEW_SEMANA, "
cQuery += cQbra+"                   NEW_ROTEIR, "
cQuery += cQbra+"                   NEW_DTREF) TRB2 "
cQuery += cQbra+"  WHERE QTD = 2 "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
*/

Return(cQuery)


//+-----------------------------------------------------------------------------------//
//|Funcao....: fQry2SRD()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 27 de maio de 2018, 09:00
//|Descricao.: 
//|          : 
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fQry2SRD(cEmpUpd)
*-----------------------------------------------------------*

Local cQuery    := ""
Local cQbra     := Chr(13)+Chr(10)

cQuery := cQbra+" SELECT RD_FILIAL || RD_MAT || RD_CC || RD_ITEM || RD_CLVL || RD_DATARQ || "
cQuery += cQbra+"        RD_PD || RD_PERIODO || RD_ROTEIR || RD_DTREF || "
cQuery += cQbra+"        RD_CONVOC AS RD_KEYOLD, "
cQuery += cQbra+"        RD_SEQ, "
cQuery += cQbra+"        RD_SEMANA, "
cQuery += cQbra+"        R_E_C_N_O_ AS RD_RECNO "
cQuery += cQbra+"   FROM SRD"+cEmpUpd+" "
cQuery += cQbra+"  WHERE RD_FILIAL || RD_MAT || RD_CC || RD_ITEM || RD_CLVL || RD_DATARQ || "
cQuery += cQbra+"        RD_PD || RD_PERIODO || RD_ROTEIR || RD_DTREF || "
cQuery += cQbra+"        RD_CONVOC IN (SELECT RD_FILIAL || RD_MAT || RD_CC || RD_ITEM || "
cQuery += cQbra+"                             RD_CLVL || RD_DATARQ || RD_PD || RD_PERIODO || "
cQuery += cQbra+"                             RD_ROTEIR || RD_DTREF || RD_CONVOC "
cQuery += cQbra+"                        FROM (SELECT RD_FILIAL, "
cQuery += cQbra+"                                     RD_MAT, "
cQuery += cQbra+"                                     RD_CC, "
cQuery += cQbra+"                                     RD_ITEM, "
cQuery += cQbra+"                                     RD_CLVL, "
cQuery += cQbra+"                                     RD_DATARQ, "
cQuery += cQbra+"                                     RD_PD, "
cQuery += cQbra+"                                     RD_SEQ, "
cQuery += cQbra+"                                     RD_PERIODO, "
cQuery += cQbra+"                                     RD_SEMANA, "
cQuery += cQbra+"                                     RD_ROTEIR, "
cQuery += cQbra+"                                     RD_DTREF, "
cQuery += cQbra+"                                     RD_CONVOC, "
cQuery += cQbra+"                                     COUNT(*) QTD "
cQuery += cQbra+"                                FROM (SELECT RD_FILIAL, "
cQuery += cQbra+"                                             RD_MAT, "
cQuery += cQbra+"                                             RD_CC, "
cQuery += cQbra+"                                             RD_ITEM, "
cQuery += cQbra+"                                             RD_CLVL, "
cQuery += cQbra+"                                             RD_DATARQ, "
cQuery += cQbra+"                                             RD_PD, "
cQuery += cQbra+"                                             ' ' AS RD_SEQ, "
cQuery += cQbra+"                                             RD_PERIODO, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
//cQuery += cQbra+"                                           RD_SEMANA, "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                             CASE "
cQuery += cQbra+"                                               WHEN RD_SEMANA = '  ' "
cQuery += cQbra+"                                               THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                               WHEN RD_SEMANA = '0' "
cQuery += cQbra+"                                               THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                               WHEN RD_SEMANA = '1' "
cQuery += cQbra+"                                               THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                               WHEN RD_SEMANA = '00' "
cQuery += cQbra+"                                               THEN '01' "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                               ELSE RD_SEMANA "
//                                         ----------------------------------------------------------------------------------------
cQuery += cQbra+"                                             END AS RD_SEMANA, "
//-----------------------------------------------------------------------------------------------------------------------------------------------------------
cQuery += cQbra+"                                             RD_ROTEIR, "
cQuery += cQbra+"                                             RD_DTREF, "
cQuery += cQbra+"                                             RD_CONVOC "
cQuery += cQbra+"                                        FROM SRD"+cEmpUpd+" "
cQuery += cQbra+"                                       WHERE RD_SEQ NOT IN ('T','U','X','Y','Z') "
//cQuery += cQbra+"                                         AND RD_FILIAL  = '31' " //TESTE
cQuery += cQbra+"                                       ) TRB "
cQuery += cQbra+"                               GROUP BY RD_FILIAL, "
cQuery += cQbra+"                                        RD_MAT, "
cQuery += cQbra+"                                        RD_CC, "
cQuery += cQbra+"                                        RD_ITEM, "
cQuery += cQbra+"                                        RD_CLVL, "
cQuery += cQbra+"                                        RD_DATARQ, "
cQuery += cQbra+"                                        RD_PD, "
cQuery += cQbra+"                                        RD_SEQ, "
cQuery += cQbra+"                                        RD_PERIODO, "
cQuery += cQbra+"                                        RD_SEMANA, "
cQuery += cQbra+"                                        RD_ROTEIR, "
cQuery += cQbra+"                                        RD_DTREF, "
cQuery += cQbra+"                                        RD_CONVOC) TRB2 "
cQuery += cQbra+"                       WHERE QTD > 1) "
cQuery += cQbra+"  ORDER BY RD_FILIAL, "
cQuery += cQbra+"           RD_MAT, "
cQuery += cQbra+"           RD_CC, "
cQuery += cQbra+"           RD_ITEM, "
cQuery += cQbra+"           RD_CLVL, "
cQuery += cQbra+"           RD_DATARQ, "
cQuery += cQbra+"           RD_PD, "
cQuery += cQbra+"           RD_SEQ "

Return(cQuery)


//+-----------------------------------------------------------------------------------//
//|Funcao....: fCriaSR0()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 23 de maio de 2018, 09:00
//|Descricao.: Essa rotina irá criar registros na tabela SR0 com base na SRA onde 
//|          : RA_XXTRANS = '000999'
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
User Function fCriaSR0()
*-----------------------------------------------------------*
Local x          :=  0
Local aNovoGrupo := {}

//-----------------------------------------------------------------------------------
//Empresas
//-----------------------------------------------------------------------------------
aAdd(aNovoGrupo,{"010","('11')"})
aAdd(aNovoGrupo,{"020","('31')"})
aAdd(aNovoGrupo,{"030","('41')"})
aAdd(aNovoGrupo,{"040","('51')"})
aAdd(aNovoGrupo,{"050","('61')"})
aAdd(aNovoGrupo,{"060","('Z1')"})
aAdd(aNovoGrupo,{"070","('Z3')"})
aAdd(aNovoGrupo,{"080","('W1')"})
aAdd(aNovoGrupo,{"090","('X1')"})
aAdd(aNovoGrupo,{"100","('U1')"})
aAdd(aNovoGrupo,{"110","('Y1')"})
aAdd(aNovoGrupo,{"120","('Z2')"})
aAdd(aNovoGrupo,{"130","('T1')"})
aAdd(aNovoGrupo,{"140","('S1')"})
//-----------------------------------------------------------------------------------

//Começar fazendo loop na nova definição dos grupos
For x:=1 To Len(aNovoGrupo)

	cEmpAnt  := SubStr(aNovoGrupo[x][01],1,2)
	cFilAnt  := SubStr(aNovoGrupo[x][02],3,2)
	
	//Inicializa Ambiente
	RPCSetType( 3 )	//Não consome licensa de uso
	RpcSetEnv(cEmpAnt,cFilAnt,,,,,{ "SR0", "SRA" })

    //Incluir registros na tabela SR0
	fIncSR0()

	//Finaliza Ambiente
	RpcClearEnv()

Next x
//-----------------------------------------------------------------------------------

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: fIncSR0()
//|Autor.....: Felipe Aurélio de Melo
//|Data......: 23 de maio de 2018, 09:00
//|Descricao.: Essa rotina irá criar registros na tabela SR0 com base na SRA onde 
//|          : RA_XXTRANS = '000999'
//|Observação: 
//+-----------------------------------------------------------------------------------//
*-----------------------------------------------------------*
Static Function fIncSR0()
*-----------------------------------------------------------*
Local cQuery := ""
Local cQbra  := Chr(13)+Chr(10)

//------------------------------------------------------------------------------------
// Query para ajustar o campo RD_SEMANA
//------------------------------------------------------------------------------------
cQuery := cQbra+"  SELECT * "
cQuery += cQbra+"   FROM "+RetSqlName("SRA")+" SRA "
cQuery += cQbra+"  WHERE SRA.D_E_L_E_T_ = ' ' "
cQuery += cQbra+"    AND RA_XXTRANS = '000999' "

//Finaliza ALIAS caso esteja aberto
If Select("TEMP") <> 0 ; TEMP->(DbCloseArea()) ; EndIf

//Monta Alias
TcQuery cQuery ALIAS "TEMP" NEW

//Define posição de pesquisa
SR0->(DbSetOrder(3))

//Posiciona no 1o registro
TEMP->(DbGoTop())
While TEMP->(!Eof())

	If SR0->(DbSeek( TEMP->RA_FILIAL + TEMP->RA_MAT + "0" ))
	    SR0->(RecLock("SR0",.F.))
		SR0->R0_TPVALE  := "0"
		SR0->R0_QDIAINF := 2
    	SR0->(MsUnLock())
	Else
	    If Reclock("SR0",.T.)
			SR0->R0_FILIAL  := TEMP->RA_FILIAL
			SR0->R0_MAT     := TEMP->RA_MAT
			SR0->R0_CODIGO  := "01"
			SR0->R0_NROPED  := "  "
			SR0->R0_TPVALE  := "0"
			SR0->R0_QDIAINF := 2
	    	SR0->(MsUnLock())
    	EndIf
	EndIf

	TEMP->(DbSkip())
End

//Finaliza ALIAS caso esteja aberto
If Select("TEMP") <> 0 ; TEMP->(DbCloseArea()) ; EndIf

Return