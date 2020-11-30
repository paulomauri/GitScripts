Você não irá fazer o UPDATE, irá fazer o CTAS (Create Table As Select).
Teste e verá que será muito mais rápido, ainda mais se você especificar NOLOGGING (depois deverá fazer um backup completo da tablespace onde está esta tabela, ou do banco todo).

Por exemplo, imagine que, na tabela T, todos os registros que contém o ID_T = ‘N’ devem ter a coluna FLAG_PROCESSADO alterada de ‘S’ para ‘N’:

SQL> CREATE TABLE SCOTT.T2 AS SELECT ID_T, 'N' FLAG_PROCESSADO FROM SCOTT.T WHERE ID_T = 'N' 
	UNION ALL 
     SELECT ID_T, 'N' FLAG_PROCESSADO FROM SCOTT.T WHERE ID_T != 'N' 
	UNION ALL 
     SELECT ID_T, 'N' FLAG_PROCESSADO FROM SCOTT.T WHERE ID_T IS NULL NOLOGGING;

SQL> DROP TABLE SCOTT.T;

SQL> RENAME TABLE SCOTT.T2 TO T;

O CTAS acima engloba os registros que tem a coluna FLAG_PROCESSADO igual a N, diferente de N, e nulas, ou seja, a tabela toda.
Depois, você terá que recriar Índices e Constraints, mas esta pode ser sua única saída em uma tabela muito grande.

--
--
