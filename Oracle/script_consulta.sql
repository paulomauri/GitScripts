SET SERVEROUTPUT ON;
DECLARE 
	v_code NUMBER;
	v_errm VARCHAR2(64);

BEGIN
	SELECT 
		VW.CODIGO_EMPRESA || ';' ||
		VW.NOME_MATRIZ || ':' ||
		VW.FILIAL || ';' ||
		VW.NOME_FILIAL
		VW.CONTA || ';' ||
		VW.NOME_CONTA || ';' ||
		VW.CCUSTO || ';' ||
		VW.NOME_CCUSTO || ';' ||
		VW.DATA || ';' ||
		VW.TIṔO_LANC || ';' ||
		VW.VALOR || ';' AS "codigo_empresa; nome_matriz; filial; nome_filial; conta; nome_conta; ccusto; nome_ccusto; data; tipo_lanc; valor"
	FROM 
		RELATORIO_RAZAO VW
	WHERE 
		VW.DATA = TRUNC(SYSDATE -1)
EXCEPTION
	WHEN OTHERS THEN
		v_code := SQLCODE;
        	v_errm := SUBSTR(SQLERRM, 1 , 64);
        	DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);		

END;
/
