
use INTEGRATION_SYSTEM
GO

create table dbo.Teste_DDM
(
	Id int identity(1,1) primary key,
	valor varchar(100) null
);
go

INSERT INTO Teste_DDM
VALUES ('email@email.com')
GO 100


-- Vamos criar um usuário para conseguirmos visualizar os dados mascarados
-- Lembre-se: Usuários com permissão db_owner ou sysadmin SEMPRE vão ver os dados sem máscara
IF (USER_ID('Teste_DDM') IS NULL)
    CREATE USER [Teste_DDM] WITHOUT LOGIN
    
GRANT SELECT ON dbo.Teste_DDM TO [Teste_DDM]
 
 
-- Visualizando os dados mascarados (Como se fosse o usuário Teste_DDM, que acabamos de criar)
EXECUTE AS USER = 'Teste_DDM'
GO
SELECT * FROM dbo.Teste_DDM
GO
REVERT -- Reverte as permissões para o seu usuário
GO

ALTER TABLE dbo.Teste_DDM ALTER COLUMN valor ADD MASKED WITH(FUNCTION = 'email()')