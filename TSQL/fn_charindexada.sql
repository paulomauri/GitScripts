--- https://www.dirceuresende.com/blog/sql-server-charindexada-uma-funcao-diferente-para-quebrar-strings-delimitadas-split/

/*

DECLARE @String VARCHAR(MAX) = 'Teste da charindexa do /Bruno Arraujo\ aqui no blog'
SELECT dbo.charindexada('/', 1, '\', 1, @String, 1)


DECLARE @String VARCHAR(MAX) = 'Teste_da_charindexa_do_/Brunno_Arraujo\_aqui_no_blog_'
SELECT dbo.charindexada('_', 0, '_', 3, @String, 1)


DECLARE @String VARCHAR(MAX) = 'Teste_da_charindexa_do_/Bruno_Arraujo\_aqui_no_blog_'
SELECT dbo.charindexada('_', 4, '_', 2, @String, 1)


DECLARE @String VARCHAR(MAX) = 'Teste_da_charindexa_do_/Brunno_Araujo\_aqui_no_blog_'
SELECT dbo.charindexada('_', 4, '_', 99, @String, 1)


DECLARE @String VARCHAR(MAX) = 'Teste;da;charindexa;do;Brunno;Araujo;aqui;no;blog;'
SELECT dbo.charindexada(';', 4, ';', 1, @String, 1)

*/


CREATE FUNCTION [dbo].[charindexada] (    
    @delimitador_esquerda VARCHAR(20) = '',
    @posicao_inicial BIGINT = 0,
    @delimitador_direita VARCHAR(20) = '',  
    @posicao_fim BIGINT = 0,                   
    @string VARCHAR(8000)= '',
    @tipo BIT = 1
)                      
RETURNS VARCHAR(8000) 
AS 
BEGIN

    DECLARE 
        @string_AUX		VARCHAR(8000),
        @CONT_AUX		BIGINT	= 0,
        @CONT_POS_INI	BIGINT	= 0,
        @DELIM_POS_INI	BIGINT	= 0,
        @POSINI_CONT	BIGINT	= 0,
        @CONT_POS_FIM	BIGINT	= 0,
        @DELIM_POS_FIM	BIGINT	= 0,
        @TAM_D_INI		BIGINT,
        @TAM_D_FIM		BIGINT,
        @tipo_FIM		VARCHAR(8000)

    SET @string_AUX = LTRIM(RTRIM(@string))
    SET @TAM_D_INI =  (CASE @delimitador_esquerda WHEN '' THEN 1 ELSE LEN(@delimitador_esquerda) END)
    SET @TAM_D_FIM =  (CASE @delimitador_direita WHEN '' THEN 1 ELSE LEN(@delimitador_direita) END)

-- ############################ CAPTURA DAS POSIÇÕES ############################

    -- ### POSIÇÃO DO 1º DELIMITADOR ###

    WHILE (@CONT_AUX < @posicao_inicial)
    BEGIN

        SET @DELIM_POS_INI	= CHARINDEX(@delimitador_esquerda,@string_AUX,0) 
        SET @string_AUX		= SUBSTRING(@string_AUX,@DELIM_POS_INI+@TAM_D_INI,LEN(@string_AUX))
        SET @CONT_AUX		= @CONT_AUX + 1		
        SET @CONT_POS_INI	= @CONT_POS_INI + @DELIM_POS_INI
    
    END

    SET @CONT_AUX = 0

    -- ### POSIÇÃO DO 2º DELIMITADOR ###

    WHILE (@CONT_AUX < @posicao_fim)
    BEGIN
        
        SET @DELIM_POS_FIM 	= CHARINDEX(@delimitador_direita,@string_AUX) 
        SET @string_AUX    	= SUBSTRING(@string_AUX,@DELIM_POS_FIM+@TAM_D_INI,LEN(@string_AUX))
        SET @CONT_AUX	 	= @CONT_AUX + 1			
        SET @CONT_POS_FIM 	= @CONT_POS_FIM + @DELIM_POS_FIM		
    
    END				

    SET @DELIM_POS_FIM = LEN(SUBSTRING(@string_AUX,0,CHARINDEX(@delimitador_direita,@string_AUX)))				

-- ############################ VALIDAÇÕES ############################

    IF (@tipo = 0 AND @delimitador_esquerda <> '') -- ### POSICAO DO DELIMITADOR ###
    BEGIN
        SELECT @tipo_FIM = @CONT_POS_INI
    END

    IF (@tipo = 1)
    BEGIN
    
        IF (@delimitador_direita = '' AND @posicao_fim = 0) -- ### POS_INI até FINAL ###
            SET @tipo_FIM = SUBSTRING(@string,@CONT_POS_INI+@TAM_D_INI,LEN(@string))
        
        IF (@delimitador_esquerda <> '' AND @delimitador_direita <> '')	-- ### POS_INI até POS_FIM ###
            SET @tipo_FIM = SUBSTRING(@string,@CONT_POS_INI+@TAM_D_INI,@CONT_POS_FIM-1) 
        
        IF (@delimitador_esquerda = '' AND @posicao_inicial = 0) -- ### INICIO até POS_FIM ###
            SET @tipo_FIM = SUBSTRING(@string,0,@CONT_POS_FIM)			
        
    END

    RETURN ISNULL(@tipo_FIM, @tipo)

END