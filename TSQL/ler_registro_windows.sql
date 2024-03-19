
-- somente é possivel ler o registro com as devidas permissões
-- EXECUTE permission was denied on the object 'xp_regread'
-- caso o campo venha com valor nulo a porta utilizada pelo sql server é dinamica


DECLARE @Instancia NVARCHAR(50)
DECLARE @Porta VARCHAR(100)
DECLARE @RegKey_Instancia NVARCHAR(500)
DECLARE @RegKey NVARCHAR(500)

SET @Instancia = CONVERT(NVARCHAR, ISNULL(SERVERPROPERTY('INSTANCENAME'), 'MSSQLSERVER'))


-- SQL Server 2000
IF ( SELECT CONVERT( VARCHAR (1), (SERVERPROPERTY ('ProductVersion'))) ) = 8
BEGIN
    
    IF (@Instancia = 'MSSQLSERVER')
        SET @RegKey = 'SOFTWARE\Microsoft\' + @Instancia + '\MSSQLServer\SuperSocketNetLib\TCP\'
    ELSE
        SET @RegKey = 'SOFTWARE\Microsoft\Microsoft SQL Server\' + @Instancia + '\MSSQLServer\SuperSocketNetLib\TCP\'
    
    EXEC master.dbo.xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'TcpPort',
        @value = @Porta OUTPUT
 
    SELECT @@SERVERNAME AS Servidor, @Instancia AS Instancia, @Porta AS Porta

END


-- SQL Server 2005 ou superiores
IF ( SELECT CONVERT( VARCHAR (1), (SERVERPROPERTY ('ProductVersion'))) ) <> 8
BEGIN

    SET @RegKey_Instancia = 'SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL'

    EXEC master.dbo.xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey_Instancia,
        @value_name = @Instancia,
        @value = @Porta OUTPUT

    SET @RegKey = 'SOFTWARE\Microsoft\Microsoft SQL Server\' + @Porta + '\MSSQLServer\SuperSocketNetLib\TCP\IPAll'

    EXEC master.dbo.xp_regread
        @rootkey = 'HKEY_LOCAL_MACHINE',
        @key = @RegKey,
        @value_name = 'TcpPort',
        @value = @Porta OUTPUT
 
    SELECT @@SERVERNAME AS Servidor, @Instancia AS Instancia, @Porta AS Porta

END

--- ler a porta via DMV
SELECT value_data
FROM sys.dm_server_registry
WHERE registry_key LIKE '%IPALL%' 
AND value_name LIKE 'Tcp%Port%'
AND NULLIF(value_data, '') IS NOT NULL
