
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


-- Vamos criar um usu�rio para conseguirmos visualizar os dados mascarados
-- Lembre-se: Usu�rios com permiss�o db_owner ou sysadmin SEMPRE v�o ver os dados sem m�scara
IF (USER_ID('Teste_DDM') IS NULL)
    CREATE USER [Teste_DDM] WITHOUT LOGIN
    
GRANT SELECT ON dbo.Teste_DDM TO [Teste_DDM]
 
 
-- Visualizando os dados mascarados (Como se fosse o usu�rio Teste_DDM, que acabamos de criar)
EXECUTE AS USER = 'Teste_DDM'
GO
SELECT * FROM dbo.Teste_DDM
GO
REVERT -- Reverte as permiss�es para o seu usu�rio
GO

ALTER TABLE dbo.Teste_DDM ALTER COLUMN valor ADD MASKED WITH(FUNCTION = 'email()')