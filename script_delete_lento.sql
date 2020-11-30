Você não irá fazer o DELETE, irá fazer o CTAS (Create Table As Select).
Teste e verá que será muito mais rápido, ainda mais se você especificar NOLOGGING (depois deverá fazer um backup completo da TABLESPACE onde está esta tabela, pois ela até então não poderá ser recuperada via ARCHIVEs).

Por exemplo, para apagar todos registros da tabela T que contem a coluna ID_T = ‘N’:

SQL> CREATE TABLE SCOTT.T2 NOLOGGING AS SELECT * FROM SCOTT.T WHERE ID_T != 'N';

SQL> DROP TABLE SCOTT.T;

SQL> RENAME TABLE SCOTT.T2 TO T;

Depois, você terá que recriar Índices e Constraints, mas esta pode ser sua única saída em uma tabela muito grande.
-- 
--

