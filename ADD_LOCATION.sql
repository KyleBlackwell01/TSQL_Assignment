DROP PROCEDURE IF EXISTS ADD_LOCATION;
GO

CREATE PROCEDURE ADD_LOCATION @PLOCCODE NVARCHAR, @PMINQTY INT, @PMAXQTY INT AS

BEGIN
    BEGIN TRY

        IF @PLOCCODE <> len(5)
            THROW 50190, 'Location Code length invalid', 1
        ELSE IF @PMINQTY < 0 OR @PMINQTY > 999
            THROW 50200, 'Minimum Qty out of range', 1
        ELSE IF @PMAXQTY < 0 OR @PMAXQTY > 999
            THROW 50210, 'Maximum Qty out of range', 1
        ELSE IF @PMINQTY > @PMAXQTY
            THROW 50220, 'Minimum Qty larger than Maximum qty', 1
        
        INSERT INTO LOCATION (LOCID, MINQTY, MAXQTY) 
        VALUES (CONCAT(@PLOCCODE,'loc'), @PMINQTY, @PMAXQTY);

    END TRY
    BEGIN CATCH
        if ERROR_NUMBER() = 2627
            THROW 50180, 'Duplicate Location ID', 1
        ELSE IF ERROR_NUMBER() = 50190
            THROW
        ELSE IF ERROR_NUMBER() = 50200
            THROW
        ELSE IF ERROR_NUMBER() = 50210
            THROW
        ELSE IF ERROR_NUMBER() = 50220
            THROW
        ELSE
            BEGIN
                DECLARE @ERRORMESSAGE NVARCHAR(MAX) = ERROR_MESSAGE();
                THROW 50000, @ERRORMESSAGE, 1
            END; 
    END CATCH;

END;

GO
select * from LOCATION;
EXEC ADD_LOCATION @PLOCCODE = '22', @PMINQTY = 4, @PMAXQTY = 9;
select * from LOCATION;
EXEC ADD_LOCATION @PLOCCODE = 22, @PMINQTY = 1, @PMAXQTY = 8;

select * from LOCATION;