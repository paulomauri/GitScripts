Um processo está rodando no Oracle e está consumindo muitos recursos, fazendo com que todos os outros processos fiquem lentos.
A solução seria matar este processo.

SQL> ALTER SYSTEM KILL SESSION '[Coloque aqui o SID], [Coloque aqui o SERIAL#]' IMMEDIATE;

E se este processo for muito importante também?
Simples, suspenda ele, coloque em PAUSE, usando o oradebug suspend, e depois você pode continua-lo.

Primeiro, você precisa saber o SPID (o PID do Sistema Operacional, no Unix/Linux):
Para saber os SPID ativos no banco de dados:

SQL> SELECT A.SID, 
	A.SERIAL#, 
	A.USERNAME, 
	A.SERVER, 
	B.SPID, 
	A.OSUSER, 
	A.MACHINE, 
	A.PROGRAM,
	 A.LOGON_TIME 
FROM V$SESSION A, V$PROCESS B 
WHERE A.PADDR=B.ADDR 
AND A.SID in (SELECT A.SID FROM V$SESSION A, V$PROCESS B WHERE A.STATUS='ACTIVE' AND A.USERNAME IS NOT NULL AND A.PADDR=B.ADDR);

Depois, use o SPID do processo que quer suspender neste comando:

SQL> oradebug setospid 6785

SQL> oradebug suspend

Depois, para reinicia-lo:

SQL> oradebug resume

