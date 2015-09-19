DELIMITER $$

DROP FUNCTION IF EXISTS `CREATE_BLITZBALL_GAME`$$ 
 
CREATE FUNCTION CREATE_BLITZBALL_GAME(p_identifier INT, p_team_name VARCHAR(30)) RETURNS INT
    NOT DETERMINISTIC
BEGIN
    DECLARE v_game_id INT;
    DECLARE v_opp1 INT;
    DECLARE v_opp2 INT;
    DECLARE v_opp3 INT;
    DECLARE v_opp4 INT;
    DECLARE v_opp5 INT;
    DECLARE v_opp6 INT;
    DECLARE v_opp7 INT;
    
    INSERT INTO BB_TEAM(TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(p_team_name, 1, 2, 3, 4, 5, 6, 500);
	SELECT LAST_INSERT_ID() INTO v_game_id;
    UPDATE BB_TEAM SET GAME_ID=v_game_id WHERE TEAM_ID=v_game_id;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(1, v_game_id, 'Wakka', 3, 21, 60, 11, 150, 3, 3, 13, 2, 1, v_game_id, 80, 12);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(2, v_game_id, 'Datto', 1, 6, 60, 12, 90, 2, 4, 8, 2, 1, v_game_id, 30, 15);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(3, v_game_id, 'Letty', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_game_id, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(4, v_game_id, 'Jassu', 1, 6, 63, 7, 100, 10, 7, 1, 5, 1, v_game_id, 10, 8);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(5, v_game_id, 'Botta', 1, 6, 60, 3, 105, 10, 6, 1, 5, 1, v_game_id, 50, 7);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(6, v_game_id, 'Keepa', 1, 6, 54, 4, 150, 2, 2, 1, 4, 5, v_game_id, 60, 16);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Luca Doers', 7, 8, 9, 10, 11, 12, 500);
	SELECT LAST_INSERT_ID() INTO v_opp1;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(7, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp1, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(8, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp1, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(9, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp1, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(10, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp1, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(11, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp1, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(12, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp1, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Guadosalam Triumphs', 13, 14, 15, 16, 17, 18, 500);
	SELECT LAST_INSERT_ID() INTO v_opp2;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(13, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp2, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(14, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp2, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(15, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp2, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(16, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp2, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(17, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp2, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(18, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp2, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Gagazet Talons', 19, 20, 21, 22, 23, 24, 500);
	SELECT LAST_INSERT_ID() INTO v_opp3;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(19, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp3, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(20, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp3, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(21, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp3, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(22, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp3, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(23, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp3, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(24, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp3, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Kilika Monsters', 25, 26, 27, 28, 29, 30, 500);
	SELECT LAST_INSERT_ID() INTO v_opp4;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(25, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp4, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(26, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp4, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(27, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp4, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(28, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp4, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(29, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp4, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(30, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp4, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Bikanel Lunatics', 31, 32, 33, 34, 35, 36, 500);
	SELECT LAST_INSERT_ID() INTO v_opp5;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(31, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp5, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(32, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp5, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(33, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp5, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(34, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp5, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(35, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp5, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(36, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp5, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Besaid Bisons', 37, 38, 39, 40, 41, 42, 500);
	SELECT LAST_INSERT_ID() INTO v_opp6;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(37, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp6, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(38, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp6, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(39, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp6, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(40, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp6, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(41, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp6, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(42, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp6, 10, 22);
    
    INSERT INTO BB_TEAM(GAME_ID, TEAM_NAME, RWING, LWING, MID, LBACK, RBACK, KEEPER, AVAILABLE_CASH) VALUES(v_game_id, 'Zanarkand Apes', 43, 44, 45, 46, 47, 48, 500);
	SELECT LAST_INSERT_ID() INTO v_opp7;
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(43, v_game_id, 'Bickson', 1, 6, 60, 12, 140, 3, 5, 12, 2, 1, v_opp7, 70, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(44, v_game_id, 'Abus', 1, 6, 60, 9, 130, 3, 4, 13, 2, 1, v_opp7, 120, 17);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(45, v_game_id, 'Graav', 1, 6, 60, 7, 95, 5, 10, 4, 5, 1, v_opp7, 40, 10);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(46, v_game_id, 'Balgerda', 1, 6, 60, 5, 141, 9, 9, 1, 8, 1, v_opp7, 110, 19);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(47, v_game_id, 'Doram', 1, 6, 60, 3, 142, 7, 7, 1, 5, 1, v_opp7, 100, 18);
    INSERT INTO BB_PLAYERS(PLAYER_ID, GAME_ID, NAME, LEVEL, NEXT_EXP, SPD, ENDUR, HP, ATK, PASS, SHOT, BLK, CAT, CURR_TEAM, SALARY, CONTRACT_LENGTH) VALUES(48, v_game_id, 'Raudy', 1, 6, 60, 4, 142, 2, 2, 1, 4, 8, v_opp7, 10, 22);
    
    INSERT INTO BB_INFO(GAME_ID, USER_ID, OPPONENT_1, OPPONENT_2, OPPONENT_3, OPPONENT_4, OPPONENT_5, OPPONENT_6, OPPONENT_7, WINS, LOSSES, GOALS, GOALS_AGAINST) VALUES (v_game_id, p_identifier, v_opp1, v_opp2, v_opp3, v_opp4, v_opp5, v_opp6, v_opp7, 0, 0, 0, 0);
 RETURN (v_game_id);
END;



GRANT ALL PRIVILEGES ON mysql.proc TO 'webapp'@'localhost';

GRANT ALL PRIVILEGES ON mysql.proc TO 'webapp'@'%';