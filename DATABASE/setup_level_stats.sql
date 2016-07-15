DELIMITER $$

DROP PROCEDURE IF EXISTS `SETUP_LEVEL_STATS`$$ 
 
CREATE PROCEDURE SETUP_LEVEL_STATS()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE currLevel INT DEFAULT 1;
    DECLARE currHp FLOAT;
    DECLARE currSpd FLOAT;
    DECLARE currEndur FLOAT;
    DECLARE currAtk FLOAT;
    DECLARE currPass FLOAT;
    DECLARE currShot FLOAT;
    DECLARE currBlk FLOAT;
    DECLARE currCat FLOAT;
    DECLARE nextLevel INT;
    DECLARE nextHp FLOAT;
    DECLARE nextSpd FLOAT;
    DECLARE nextEndur FLOAT;
    DECLARE nextAtk FLOAT;
    DECLARE nextPass FLOAT;
    DECLARE nextShot FLOAT;
    DECLARE nextBlk FLOAT;
    DECLARE nextCat FLOAT;
    
    WHILE i < 60 DO
        SET i = i + 1;
        SET nextLevel=1;
        SET currLevel=0;
        SELECT HP, SPD, ENDUR, ATK, PASS, SHOT, BLK, CAT INTO currHp, currSpd, currEndur, currAtk, currPass, currShot, currBlk, currCat FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=i AND LEVEL=1;
        levelLoop: WHILE currLevel < 30 DO
			SET currLevel = currLevel + 1;
            IF (nextLevel=currLevel) THEN
				SELECT LEVEL, HP, SPD, ENDUR, ATK, PASS, SHOT, BLK, CAT INTO nextLevel, nextHp, nextSpd, nextEndur, nextAtk, nextPass, nextShot, nextBlk, nextCat FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=i AND LEVEL=(SELECT MIN(LEVEL) FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=i AND LEVEL>currLevel);
				ITERATE levelLoop;
            END IF;
            SET currHp = currHp+(nextHp-currHp)/(1+nextLevel-currLevel);
            SET currSpd = currSpd+(nextSpd-currSpd)/(1+nextLevel-currLevel);
            SET currEndur = currEndur+(nextEndur-currEndur)/(1+nextLevel-currLevel);
            SET currAtk = currAtk+(nextAtk-currAtk)/(1+nextLevel-currLevel);
            SET currPass = currPass+(nextPass-currPass)/(1+nextLevel-currLevel);
            SET currShot = currShot+(nextShot-currShot)/(1+nextLevel-currLevel);
            SET currBlk = currBlk+(nextBlk-currBlk)/(1+nextLevel-currLevel);
            SET currCat = currCat+(nextCat-currCat)/(1+nextLevel-currLevel);
            INSERT INTO BB_PLAYER_LVL_STATS(PLAYER_ID, LEVEL, HP, SPD, ENDUR, ATK, PASS, SHOT, BLK, CAT) VALUES (i, currLevel, ROUND(currHp), ROUND(currSpd), ROUND(currEndur), ROUND(currAtk), ROUND(currPass), ROUND(currShot), ROUND(currBlk), ROUND(currCat));
		END WHILE;
    END WHILE;
END;

CALL SETUP_LEVEL_STATS();

DROP PROCEDURE `SETUP_LEVEL_STATS`$$
