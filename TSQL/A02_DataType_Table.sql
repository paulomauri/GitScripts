
CREATE TABLE dbo.Teste
(
	Codigo BIGINT,
	Descricao VARCHAR(1000)
)
GO

CREATE TYPE dbo.dtTipoTable
AS TABLE (
	Codigo BIGINT,
	Descricao VARCHAR(1000)
)
GO

CREATE PROCEDURE dbo.prc_inserir
	@Tabela dtTipoTable readonly
AS
BEGIN
	INSERT dbo.Teste (Codigo, Descricao)
	SELECT * from @Tabela
END

DECLARE @Tipo AS dtTipoTable

INSERT @Tipo
VALUES (1,'A'), (2,'B'), (3,'C')

EXEC dbo.prc_inserir @Tipo

SELECT * FROM dbo.Teste

-- DROP TABLE dbo.Teste

-- DROP PROCEDURE dbo.prc_inserir

-- DROP TYPE dbo.dtTipoTable