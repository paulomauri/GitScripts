Short Scripts
— Short Script 1 – Obtendo a lista de EventClass —
DECLARE @id INT = ( SELECT id FROM sys.traces WHERE is_default = 1 )
SELECT Distinct eventid, name
FROM fn_trace_geteventinfo(@id) A JOIN sys.trace_events B ON A.eventid = B.trace_event_id
Go
— Short Script 2 – Comparativo básico entre as funções IsNull() e Coalesce() —
CREATE TABLE Strings (String1 varchar(5),
String2 varchar(10),
string3 varchar(5),
string4 varchar(10))
Go 

INSERT INTO dbo.Strings (String1, String2, String3, string4)
VALUES(‘Hello’,NULL,NULL,’Goodbye’)
Go 

SELECT ISNULL(String1, String2) AS Expr1,
COALESCE(String1, String2) AS Expr2,
ISNULL(String3, String4) AS Expr3,
COALESCE(String3, String4) AS Expr4
FROM Strings
Go
 
— Short Script 3 – Utilizando – Fn_trace_gettable para identificar quem criou a tabela —
DECLARE @CaminhoLog Nvarchar(2000)
SELECT @CaminhoLog = convert(Nvarchar(max),value) from ::fn_trace_getinfo(0)
where property = 2
— Identificando os eventos de criação e exclusão de tabelas —
SELECT SPID, LoginName, NTUserName, NTDomainName, HostName, ApplicationName, StartTime, ServerName, DatabaseName,
CASE EventClass
WHEN 46 THEN ‘CREATE’
WHEN 47 THEN ‘DROP’
ELSE ‘OTHER’
END AS EventClass,
CASE ObjectType
WHEN 8277 THEN ‘User defined Table’
ELSE ‘OTHER’
END AS ObjectType,
ObjectID,
ObjectName
FROM fn_trace_gettable (@CaminhoLog, Default)
Where EventSubClass = 1 /* Evento comitado */
And ObjectType = 8277 — Id relacionado a eventos de tabela
ORDER BY StartTime
GO

— Short Script 4 – Identificando as Heap Tables existentes —
SELECT SCH.name + ‘.’ + TBL.name as TableName
From sys.indexes as IDX Inner join sys.tables as TBL
On TBL.object_id = IDX.object_id
Inner join  sys.schemas as SCH
On TBL.schema_id = SCH.schema_id
Where IDX.type = 0 –> Heap
Order by TableName
Go
— Short Script 5 – Identificando o número ausente em uma sequência numérica —
Create Table Dados
(Codigo Int,
Num_doc Int,
Serie Int)
Go
— Inserindo os dados —
Insert Into Dados
Values(1,1,1), (2,1,2), (3,3,2),
(4,2,1), (5,3,1), (6,5,1),
(7,7,1), (8,5,2)
Go 

— Consultando —
Select * From Dados
Order By Num_doc, Serie
Go 

— Executando a CTE e identificando os possíveis GAPS —
Select (Num_Doc+1) As Proximo, Serie
From Dados
Where (Num_Doc+1) Not In (Select Num_Doc From Dados Where Serie = Dados.Serie)
Order By Serie
Go

— Short Script 6 – Exemplo – Obtendo a lista de EventClass —
— Exemplo 1 —
Declare @UltimoDiaMes date, @UltimaSegundaFeira date
— Último dia do mês
Set @UltimoDiaMes= eomonth(cast(current_timestamp as date)) 

— Última segunda-feira do mês
Set Datefirst 1  — considera semana iniciando na segunda-feira
Set @UltimaSegundaFeira= dateadd(day,
-datepart(dw, @UltimoDiaMes) +1,
@UltimoDiaMes) 

SELECT @UltimoDiaMes, @UltimaSegundaFeira
Go— Exemplo 2 —

Declare @UltimoDiaMes date, @UltimaSegundaFeira date;

— Último dia do mês
Set @UltimoDiaMes= dateadd(day, -1, dateadd(month, datediff(month, 0, current_timestamp) +1, 0))

— Última segunda-feira do mês
Set Datefirst 1  — considera semana iniciando na segunda-feiraSet @UltimaSegundaFeira= dateadd(day,
-datepart(dw, @UltimoDiaMes) +1,
@UltimoDiaMes)


SELECT @UltimoDiaMes, @UltimaSegundaFeira
Go