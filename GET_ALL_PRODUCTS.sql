DROP PROCEDURE IF EXISTS GET_ALL_PRODUCTS
GO

CREATE PROCEDURE GET_ALL_PRODUCTS @POUTCUR CURSOR VARYING OUTPUT AS
BEGIN
    BEGIN TRY
       SET @POUTCUR = CURSOR FOR SELECT * FROM PRODUCT;
       OPEN @POUTCUR;
    END TRY
    BEGIN CATCH
        DECLARE @ERRORMESSAGE NVARCHAR(MAX) = ERROR_MESSAGE();
        THROW 50000, @ERRORMESSAGE, 1
    END CATCH
END;
GO





BEGIN
    DECLARE @CUR CURSOR
    EXEC GET_ALL_PRODUCTS @POUTCUR = @CUR OUTPUT;

    DECLARE @PRODID INT,
            @PRODNAME NVARCHAR(100),
            @PRICE MONEY,
            @SALES_YTD MONEY;

    FETCH NEXT FROM @CUR INTO @PRODID, @PRODNAME, @PRICE, @SALES_YTD;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT(CONCAT('ID: ', @PRODID, ' Name: ', @PRODNAME, ' Price: ', @PRICE, ' SALES YTD: ', @SALES_YTD))
        FETCH NEXT FROM @CUR INTO @PRODID, @PRODNAME, @PRICE, @SALES_YTD
    END;
    CLOSE @CUR;
    DEALLOCATE @CUR;
END;