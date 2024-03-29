DROP PROCEDURE IF EXISTS UPD_PROD_SALESYTD;
GO

CREATE PROCEDURE UPD_PROD_SALESYTD @PPRODID int, @PAMT INT AS

BEGIN
    BEGIN TRY

        IF (@PPRODID IS NULL)
            THROW 50100, 'Product ID not found.', 1
        ELSE IF @PAMT < -999.99 OR @PAMT > 999.99
            THROW 50110, 'Amount out of range.', 1

        UPDATE PRODUCT
            SET SALES_YTD = @PAMT + SALES_YTD
            WHERE PRODID = @PPRODID
    END TRY
    BEGIN CATCH

        IF ERROR_NUMBER() = 50100
            THROW
        ELSE IF ERROR_NUMBER() = 50110
            THROW
        ELSE
            BEGIN
                DECLARE @ERRORMESSAGE NVARCHAR(MAX) = ERROR_MESSAGE();
                THROW 50000, @ERRORMESSAGE, 1
            END;
    END CATCH;

END;
GO

SELECT * FROM PRODUCT;

EXEC UPD_PROD_SALESYTD @PPRODID = 1500, @PAMT = 250;

SELECT * FROM PRODUCT;