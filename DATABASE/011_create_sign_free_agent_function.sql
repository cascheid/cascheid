DELIMITER $$

DROP FUNCTION IF EXISTS `SIGN_FREE_AGENT`$$ 
 
CREATE FUNCTION SIGN_FREE_AGENT(p_game_id INT, p_replacing_id INT) RETURNS INT
    NOT DETERMINISTIC
BEGIN
	DECLARE tempID INT;
    DECLARE position VARCHAR(2);
	DECLARE done INT DEFAULT FALSE;
    DECLARE tempVAL DECIMAL(5, 2);
    DECLARE leadingVAL DECIMAL(5, 2);
    DECLARE leadingID INT;
	DECLARE cur CURSOR FOR  SELECT PLAYER_ID FROM BB_PLAYERS WHERE CURR_TEAM=0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	SELECT LEVEL, CURR_TEAM INTO @eval_lvl, @curr_team FROM BB_PLAYERS WHERE PLAYER_ID=p_replacing_id AND GAME_ID=p_game_id;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND MID=p_replacing_id;
    IF (@count>0) THEN
		SET position='MF';
	END IF;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND LWING=p_replacing_id;
    IF (@count>0) THEN
		SET position='LW';
	END IF;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND RWING=p_replacing_id;
    IF (@count>0) THEN
		SET position='RW';
	END IF;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND LBACK=p_replacing_id;
    IF (@count>0) THEN
		SET position='LB';
	END IF;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND RBACK=p_replacing_id;
    IF (@count>0) THEN
		SET position='RB';
	END IF;
    SELECT COUNT(*) INTO @count FROM BB_TEAM WHERE GAME_ID=p_game_id AND KEEPER=p_replacing_id;
    IF (@count>0) THEN
		SET position='GK';
	END IF;
    
	OPEN cur;
    SET leadingVAL=0;
        
	read_loop: LOOP
		FETCH cur INTO tempID;
		IF done THEN
			LEAVE read_loop;
		END IF;
        IF (position='MF') THEN
			SELECT (.75+RAND()/4)*(5*PASS+3*ENDUR+2*BLK+2*ATK) INTO tempVAL FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=tempID AND LEVEL=@eval_lvl;
        ELSEIF (position='LW' OR position='RW') THEN
			SELECT (.75+RAND()/4)*(7*SHOT+5*ENDUR) INTO tempVAL FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=tempID AND LEVEL=@eval_lvl;
        ELSEIF (position='LB' OR position='RB') THEN
			SELECT (.75+RAND()/4)*(8*ATK+3*BLK+1*PASS) INTO tempVAL FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=tempID AND LEVEL=@eval_lvl;
        ELSEIF (position='GK') THEN
			SELECT (.75+RAND()/4)*(12*CAT) INTO tempVAL FROM BB_PLAYER_LVL_STATS WHERE PLAYER_ID=tempID AND LEVEL=@eval_lvl;
        END IF;
        IF (tempVAL>leadingVAL) THEN
			SET leadingVAL=tempVal;
            SET leadingID=tempID;
		END IF;
	END LOOP;	
		
    IF (position='MF') THEN
		UPDATE BB_TEAM SET MID=leadingID WHERE TEAM_ID=@curr_team;
	ELSEIF (position='LW') THEN
		UPDATE BB_TEAM SET LWING=leadingID WHERE TEAM_ID=@curr_team;
	ELSEIF (position='RW') THEN
		UPDATE BB_TEAM SET RWING=leadingID WHERE TEAM_ID=@curr_team;
	ELSEIF (position='LB') THEN
		UPDATE BB_TEAM SET LBACK=leadingID WHERE TEAM_ID=@curr_team;
	ELSEIF (position='RB') THEN
		UPDATE BB_TEAM SET RBACK=leadingID WHERE TEAM_ID=@curr_team;
	ELSEIF (position='GK') THEN
		UPDATE BB_TEAM SET KEEPER=leadingID WHERE TEAM_ID=@curr_team;
	END IF;
	UPDATE BB_PLAYERS SET CURR_TEAM=@curr_team, CONTRACT_LENGTH=FLOOR(5+RAND()*15) WHERE PLAYER_ID=leadingID;
	UPDATE BB_PLAYERS SET CURR_TEAM=0 WHERE PLAYER_ID=p_replacing_id;
    
    RETURN leadingID;
END;