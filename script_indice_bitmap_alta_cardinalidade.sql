Os índices BITMAP podem ser uteis sim, em colunas com cardinalidade maior.

Veja no teste abaixo, onde utilizei uma coluna com cardinalidade bem maior (de 28/10936000 para 40998/10936000), e pelo menos para agregações, a performance com BITMAP foi muito melhor (3x) do que o Índice BTREE. O ganho foi muito menor do que na cardinalidade menor, demonstrada no teste anterior, mas mesmo assim um ganho de 300% é muito bom.

-- CREATE TABLE T AS SELECT * FROM DBA_OBJECTS;
-- INSERT INTO T SELECT * FROM DBA_OBJECTS; FAZER ESTE INSERT SELECT VARIAS VEZES.

SQL> SELECT COUNT(1) FROM T;

COUNT(1)
———-
10936000

Decorrido: 00:00:00.03
SQL> SELECT COUNT(DISTINCT(OWNER)) FROM T;

COUNT(DISTINCT(OWNER))
———————-
28

Decorrido: 00:00:01.87
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:26.03
SQL> CREATE INDEX T_IDX2_BTREE ON T(OBJECT_NAME);

-ndice criado.

Decorrido: 00:03:37.48
SQL> EXEC DBMS_STATS.GATHER_TABLE_STATS(‘SCOTT’, ‘T’, CASCADE=>TRUE);

Procedimento PL/SQL concluÝdo com sucesso.

Decorrido: 00:01:00.10
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:09.90
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:09.01
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:08.95
SQL> DROP INDEX T_IDX2_BTREE;

-ndice eliminado.

Decorrido: 00:00:00.37
SQL> CREATE BITMAP INDEX T_IDX2_BTREE ON T(OBJECT_NAME);

-ndice criado.

Decorrido: 00:00:43.67
SQL> EXEC DBMS_STATS.GATHER_TABLE_STATS(‘SCOTT’, ‘T’, CASCADE=>TRUE);

Procedimento PL/SQL concluÝdo com sucesso.

Decorrido: 00:01:02.87
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:03.14
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:02.45
SQL> SELECT COUNT(DISTINCT(OBJECT_NAME)) FROM T;

COUNT(DISTINCT(OBJECT_NAME))
—————————-
40998

Decorrido: 00:00:03.15
SQL>

Tempo do COUNT DISTINCT com índice BTREE: 9 segundos, 9 segundos e 8 segundos.

Tempo do COUNT DISTINCT com índice BITMAP: 3 segundos, 2 segundos e 3 segundos.

Então, devemos ter cuidado com o que chamamos de alta cardinalidade. Testar é sempre a melhor opção.
