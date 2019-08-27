DROP PROCEDURE IF EXISTS UPD_CUST_SALESYTD;
GO

CREATE PROCEDURE UPD_CUST_SALESYTD @PCUSTID int, @PAMT INT AS

BEGIN
    BEGIN TRY

        IF (@PCUSTID IS NULL)
            THROW 50070, 'Customer ID not found.', 1
        ELSE IF @PAMT < -999.99 OR @PAMT > 999.99
            THROW 50080, 'Amount out of range.', 1

        UPDATE CUSTOMER
            SET SALES_YTD = @PAMT
            WHERE CUSTID = @PCUSTID
    END TRY
    BEGIN CATCH

        IF ERROR_NUMBER() = 50070
            THROW
        ELSE IF ERROR_NUMBER() = 50080
            THROW
        ELSE
            BEGIN
                DECLARE @ERRORMESSAGE NVARCHAR(MAX) = ERROR_MESSAGE();
                THROW 50000, @ERRORMESSAGE, 1
            END;
    END CATCH;

END;
GO

select * from customer;

EXEC UPD_CUST_SALESYTD @PCUSTID = 1, @PAMT = 250;

select * from customer;