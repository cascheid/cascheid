DELIMITER $$

DROP PROCEDURE IF EXISTS `DEFINE_EXP_LEVELS`$$ 
 
CREATE PROCEDURE DEFINE_EXP_LEVELS()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE lastExp INT DEFAULT 0;
    
    WHILE i < 30 DO
        SET i = i + 1;
        SET lastExp = lastExp + 10*(POWER(1.15, i-1));
        INSERT INTO BB_EXP_LVL_LOOKUP (LEVEL, EXP) VALUES (i, lastExp);
    END WHILE;
END;

CALL DEFINE_EXP_LEVELS();

DROP PROCEDURE `DEFINE_EXP_LEVELS`$$
