DROP PROCEDURE IF EXISTS GET_ALL_CUSTOMERS
GO

CREATE PROCEDURE GET_ALL_CUSTOMERS AS
DECLARE @CustomerCursor CURSOR
    @CustomerCursor = SELECT * FROM Customer
    OPEN @CustomerCursor
        FETCH NEXT FROM @CustomerCursor;
GO

EXEC GET_ALL_CUSTOMERS

-- DECLARE @MyCursor CURSOR;
-- EXEC GET_ALL_CUSTOMERS @CustomerCursor = @MyCursor OUTPUT;
-- WHILE (@@FETCH_STATUS = 0)  
-- BEGIN;  
--      FETCH NEXT FROM @MyCursor;  
-- END;  
-- CLOSE @MyCursor;  
-- DEALLOCATE @MyCursor;  
-- GO
