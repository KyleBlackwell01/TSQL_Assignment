DROP PROCEDURE IF EXISTS ADD_COMPLEX_SALE;
GO

CREATE PROCEDURE ADD_COMPLEX_SALE @PCUSTID INT, @PPRODID INT, @PQTY INT, @PDate NVARCHAR(max) AS

BEGIN
    BEGIN TRY
    DECLARE @STATUS nvarchar = (SELECT STATUS FROM CUSTOMER WHERE @PCUSTID = CUSTID);
    DECLARE @PAMT int = (SELECT @PQTY * (SELLING_PRICE) FROM PRODUCT WHERE @PPRODID = PRODID)
    --DECLARE @SALE_SEQ int = (SELECT OBJECT_ID('SALE_SEQ'))
    DECLARE @SALEID bigint = NEXT VALUE FOR SALE_SEQ

        
        IF @PQTY < 1 OR @PQTY > 999
            THROW 50320, 'Sale Quantity outside valid range.', 1
        ELSE IF (@STATUS = 'OK')
            THROW 50240, 'Customer status is not OK.', 1
        ELSE IF (@PDate IS NULL)
            THROW 50250, 'Date not valid', 1
        ELSE IF (@PCUSTID IS NULL)
            THROW 50260, 'Customer ID not found.', 1
        ELSE IF (@PPRODID IS NULL)
            THROW 50270, 'Product ID not found.', 1

        -- UPDATE SALE
        --     SET SALEDATE = @PDate
        --     WHERE CUSTID = @PCUSTID



        INSERT INTO SALE (SALEID, CUSTID, PRODID, QTY, PRICE, SALEDATE)
        VALUES (@SALEID, @PCUSTID, @PPRODID, @PQTY, @PAMT, @PDATE);
            
        EXEC UPD_CUST_SALESYTD @PCUSTID, @PAMT;
        EXEC UPD_PROD_SALESYTD @PPRODID, @PAMT;
        
    END TRY
    BEGIN CATCH

        IF ERROR_NUMBER() = 50320
            THROW
        ELSE IF ERROR_NUMBER() = 50240
            THROW
        ELSE IF ERROR_NUMBER() = 50250
            THROW
        ELSE IF ERROR_NUMBER() = 50260
            THROW
        ELSE IF ERROR_NUMBER() = 50270
            THROW
        ELSE
           -- BEGIN
                --DECLARE @ERRORMESSAGE NVARCHAR(MAX) = ERROR_MESSAGE();
                --THROW 50000, @ERRORMESSAGE, 1
                THROW
           -- END;
    END CATCH;

END;
GO

SELECT * FROM CUSTOMER;
SELECT * FROM PRODUCT;
SELECT * FROM SALE;

EXEC ADD_COMPLEX_SALE @PCUSTID = 1, @PPRODID = 1706, @PQTY = 1, @PDate = '2018-01-22';
EXEC ADD_COMPLEX_SALE @PCUSTID = 3, @PPRODID = 1707, @PQTY = 1, @PDate = '2018-01-25';
EXEC ADD_COMPLEX_SALE @PCUSTID = 3, @PPRODID = 1707, @PQTY = 1, @PDate = '2019-09-08';
EXEC ADD_COMPLEX_SALE @PCUSTID = 3, @PPRODID = 1707, @PQTY = 1, @PDate = '2019-09-09';

SELECT * FROM CUSTOMER;
SELECT * FROM PRODUCT;
SELECT * FROM SALE;