CREATE TABLE BB_TECHS(
 TECH_ID INT AUTO_INCREMENT PRIMARY KEY,
 TECH_NAME VARCHAR(30) NOT NULL,
 DESCRIPTION VARCHAR(200) NOT NULL,
 TECH_TYPE VARCHAR(7) NOT NULL,
 HP_COST INT NOT NULL,
 STAT_MOD INT,
 ANIMATION VARCHAR(30)
);

CREATE TABLE BB_PLAYER_TECHS(
 GAME_ID INT NOT NULL,
 PLAYER_ID INT NOT NULL,
 TECH_ID INT NOT NULL,
 LEARNED BOOLEAN NOT NULL,
 PRIMARY KEY(GAME_ID, PLAYER_ID, TECH_ID)
);

INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Jecht Shot', 'Eliminates two defenders.', 'SHOT', 120, 5, 'jechtshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Jecht Shot 2', 'Eliminates three defenders and has the Invisible Shot effect.', 'SHOT', 999, 10, 'jechtshot2anim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Sphere Shot', 'Boosts SH by a random amount. Adds 0-10 if player lv is 1-19, 0-15 if lv is 20-39, and 0-20 if lv is 40 or more.', 'SHOT', 90, 3, 'sphereshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Invisible Shot', '60% chance of the ball turning invisible. If the ball reaches the goal and SH is not 0, the player has 5 seconds to steer the ball past the goalkeeper.', 'SHOT', 220, 3, 'invisshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Shot', 'If the goalkeeper touches the ball, 40% chance of inflicting Poison.', 'SHOT', 20, 3, 'venomshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Shot 2', 'If the goalkeeper touches the ball, 70% chance of inflicting Poison.', 'SHOT', 35, 5, 'venomshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Shot 3', 'If the goalkeeper touches the ball, Poison is inflicted.', 'SHOT', 100, 7, 'venomshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Shot', 'If the goalkeeper touches the ball, 40% chance of inflicting Sleep.', 'SHOT', 45, 3, 'napshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Shot 2', 'If the goalkeeper touches the ball, 70% chance of inflicting Sleep.', 'SHOT', 80, 5, 'napshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Shot 3', 'If the goalkeeper touches the ball, Sleep is inflicted.', 'SHOT', 350, 7, 'napshotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Shot', 'If the goalkeeper touches the ball, 40% chance of halving BL or CA.', 'SHOT', 30, 3, 'withershotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Shot 2', 'If the goalkeeper touches the ball, 70% chance of halving BL or CA.', 'SHOT', 180, 5, 'withershotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Shot 3', 'If the goalkeeper touches the ball, halves BL or CA.', 'SHOT', 390, 7, 'withershotanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Pass', '30% chance of inflicting Poison on opponents who touch the ball.', 'PASS', 40, 3, 'venompassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Pass 2', '60% chance of inflicting Poison on opponents who touch the ball.', 'PASS', 120, 5, 'venompassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Pass 3', 'Inflicts Poison on opponents who touch the ball.', 'PASS', 250, 7, 'venompassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Pass', '30% chance of inflicting Sleep on opponents who touch the ball.', 'PASS', 40, 3, 'nappassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Pass 2', '60% chance of inflicting Sleep on opponents who touch the ball.', 'PASS', 200, 5, 'nappassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Pass 3', 'Inflicts Sleep on opponents who touch the ball.', 'PASS', 510, 7, 'nappassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Pass', '30% chance of halving EN, AT or BL on opponents who touch the ball.', 'PASS', 40, 3, 'witherpassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Pass 2', '60% chance of halving EN, AT or BL on opponents who touch the ball.', 'PASS', 180, 5, 'witherpassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Pass 3', 'Halves EN, AT or BL on opponents who touch the ball.', 'PASS', 400, 7, 'witherpassanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Volley Shot', '50% chance of picking up a dropped ball and shooting straight for goal.', 'SPECIAL', 10);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Volley Shot 2', '75% chance of picking up a dropped ball and shooting straight for goal.', 'SPECIAL', 10);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Volley Shot 3', 'Picks up a dropped ball and shooting straight for goal.', 'SPECIAL', 10);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Tackle', '40% chance of inflicting Poison.', 'ATTACK', 30, 3, 'venomtackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Tackle 2', '70% chance of inflicting Poison.', 'ATTACK', 70, 5, 'venomtackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Venom Tackle 3', 'Inflicts Poison.', 'ATTACK', 160, 3, 'venomtackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Tackle', '40% chance of inflicting Sleep.', 'ATTACK', 40, 3, 'naptackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Tackle 2', '70% chance of inflicting Sleep.', 'ATTACK', 90, 5, 'naptackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Nap Tackle 3', 'Inflicts Sleep.', 'ATTACK', 180, 3, 'naptackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Tackle', '40% chance of halving EN, PA or SH.', 'ATTACK', 8, 3, 'withertackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Tackle 2', '70% chance of halving EN, PA or SH.', 'ATTACK', 80, 5, 'withertackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Wither Tackle 3', 'Halves EN, PA or SH.', 'ATTACK', 250, 3, 'withertackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Drain Tackle', '40% chance of absorbing 30 HP from the target. If either the tackler of person being tackled is poisoned, Drain Tackle always works.', 'ATTACK', 0, 0, 'draintackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Drain Tackle 2', '70% chance of absorbing 30 HP from the target. If either the tackler of person being tackled is poisoned, Drain Tackle 2 always works. ', 'ATTACK', 0, 0, 'draintackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST, STAT_MOD, ANIMATION) VALUES ('Drain Tackle 3', 'Drains 500 HP from the target.', 'ATTACK', 0, 0, 'draintackleanim');
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Tackle Slip', '40% chance of evading tackles without losing EN. May leave the player disoriented. If so, further tackles cause temporary loss of one of their techniques at random (for the rest of the current half).', 'SPECIAL', 40);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Tackle Slip 2', '80% chance of evading tackles without losing EN. May leave the player disoriented. If so, further tackles cause temporary loss of one of their techniques at random (for the rest of the current half).', 'SPECIAL', 180);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Venom', '50% chance of preventing Poison.', 'SPECIAL', 5);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Venom 2', 'Always prevents Poison.', 'SPECIAL', 50);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Nap', '50% chance of preventing Sleep.', 'SPECIAL', 40);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Nap 2', 'Always prevents Sleep.', 'SPECIAL', 210);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Wither', '50% chance of preventing Wither.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Wither 2', 'Always prevents Wither.', 'SPECIAL', 200);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Drain', '50% chance of preventing Drain.', 'SPECIAL', 10);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Anti-Drain 2', 'Always prevents Drain.', 'SPECIAL', 50);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Spin Ball', 'If the goalkeeper blocks the shot, chance of dropping the ball increases to 70%.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Grip Gloves', 'If the Keeper blocks a shot, chance of dropping the ball is only 10%.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'The players'' field of vision is increased by 30%, allowing them to chase opponents from further away.', 'SPECIAL', 5);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Brawler', '60% chance the player will become involved in encounters from further away. ', 'SPECIAL', 10);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Pile Venom', 'Inflict Poison up to five times cumulatively.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Pile Wither', 'Inflict Wither up to five times cumulatively.', 'SPECIAL', 70);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Regen', 'HP recovery when not in possession is quadrupled.', 'SPECIAL', 50);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Good Morning!', '50% chance of powering up when recovering from Sleep. If woken by a Venom technique: PA and CA, Nap technique: AT and PA, Wither technique: CA and SH, Otherwise: any stat other than HP or SPD.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Hi Risk', 'All stats except HP and SPD are halved, but exp. gain is doubled.', 'SPECIAL', 300);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Golden Arm', 'SH and PA loss from water resistance is halved.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Gamble', '50% chance of randomizing all stats except HP and SPD when recovering from Sleep. ', 'SPECIAL', 300);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Super Goalie', '60% chance of adding random amount from 0-10 to CA. The HP cost is increased by the amount added to the CA.', 'SPECIAL', 30);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);
INSERT INTO BB_TECHS(TECH_NAME, DESCRIPTION, TECH_TYPE, HP_COST) VALUES ('Elite Defense', 'Increases the players'' field of view by 30% when defending, allowing them to identify ball carriers and engage faster.', 'SPECIAL', 80);