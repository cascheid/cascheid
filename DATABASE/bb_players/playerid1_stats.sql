INSERT INTO BB_PLAYER_LVL_STATS(PLAYER_ID, LEVEL, HP, SPD, SHOT, ENDUR, PASS, ATK, BLK, CAT, SALARY) 
VALUES (1, 1, 132, 60, 10, 10, 3, 3, 2, 1, 40);
INSERT INTO BB_PLAYER_LVL_STATS(PLAYER_ID, LEVEL, HP, SPD, SHOT, ENDUR, PASS, ATK, BLK, CAT, SALARY) 
VALUES (1, 8, 905, 65, 21, 23, 10, 7, 5, 1, 105);
INSERT INTO BB_PLAYER_LVL_STATS(PLAYER_ID, LEVEL, HP, SPD, SHOT, ENDUR, PASS, ATK, BLK, CAT) 
VALUES (1, 18, 1890, 68, 28, 29, 14, 13, 14, 1, 170);
INSERT INTO BB_PLAYER_LVL_STATS(PLAYER_ID, LEVEL, HP, SPD, SHOT, ENDUR, PASS, ATK, BLK, CAT) 
VALUES (1, 30, 3240, 80, 55, 58, 34, 25, 22, 1, 310);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, -1, 4);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 5);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 3, 6);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 1);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 2);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 7);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 8);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 9);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 10);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 11);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 12);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 25);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 26);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 3, 27);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 40);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 3, 41);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 1, 52);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 61);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 42);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 43);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 44);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 46);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 0, 48);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 49);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 2, 50);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 3, 56);
INSERT INTO BB_KEY_TECH_UNLOCKS (PLAYER_ID, KEY_TECH, LEARNABLE_TECH)
VALUES (1, 3, 57);
UPDATE BB_KEY_TECH_UNLOCKS SET KEY_TECH=1 WHERE KEY_TECH=1 AND PLAYER_ID=1;
UPDATE BB_KEY_TECH_UNLOCKS SET KEY_TECH=15 WHERE KEY_TECH=2 AND PLAYER_ID=1;
UPDATE BB_KEY_TECH_UNLOCKS SET KEY_TECH=2 WHERE KEY_TECH=3 AND PLAYER_ID=1;