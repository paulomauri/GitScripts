	SELECT TO_CHAR('codigo_empresa; nome_matriz; filial; nome_filial; conta; nome_conta; ccusto; nome_ccusto; data; tipo_lanc; valor') AS "COLUNA"
	FROM dual
	UNION ALL
	SELECT TO_CHAR(VW.CODIGO_EMPRESA || ';' ||
		VW.NOME_MATRIZ || ':' ||
		VW.FILIAL || ';' ||
		VW.NOME_FILIAL || ';' ||
		VW.CONTA || ';' ||
		VW.NOME_CONTA || ';' ||
		VW.CCUSTO || ';' ||
		VW.NOME_CCUSTO || ';' ||
		VW.DATA || ';' ||
		VW.TIṔO_LANC || ';' ||
		VW.VALOR || ';') AS "COLUNA"
	FROM RELATORIO_RAZAO VW
	WHERE VW.DATA = TRUNC(SYSDATE) -1;
		

