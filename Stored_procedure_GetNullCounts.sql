/******************************************************
-- Stored procedure to get null counts of all columns in a table
*******************************************************/

DELIMITER //

CREATE PROCEDURE GetNullCounts(IN db_name VARCHAR(64), IN tbl_name VARCHAR(64))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE col_name VARCHAR(64);
    DECLARE cur CURSOR FOR 
        SELECT COLUMN_NAME 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_SCHEMA = db_name AND TABLE_NAME = tbl_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Temporary results table
    DROP TEMPORARY TABLE IF EXISTS null_results;
    CREATE TEMPORARY TABLE null_results (
        column_name VARCHAR(64),
        null_count BIGINT
    );

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO col_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET @qry = CONCAT(
            'INSERT INTO null_results (column_name, null_count) ',
            'SELECT ''', col_name, ''', COUNT(*) ',
            'FROM ', db_name, '.', tbl_name, 
            ' WHERE ', col_name, ' IS NULL'
        );

        PREPARE stmt FROM @qry;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    CLOSE cur;

    -- Show results
    SELECT * FROM null_results;
END //

DELIMITER ;


CALL GetNullCounts('green_trips', 'green_trips');