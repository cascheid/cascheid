
alter table RACING_GAME modify column RACING_CLASS VARCHAR(2);

alter table UPGRADES modify column RACING_CLASS VARCHAR(2);


alter table UPGRADES modify column RELIABILITY_MOD DECIMAL(3,3);

alter table UPGRADES modify column LAP_EFFICIENCY_MOD DECIMAL(3,3);


alter table RACECARS modify column RACING_CLASS VARCHAR(2);

alter table RACECARS add column NAME VARCHAR(40);

alter table RACECARS modify column RELIABILITY DECIMAL(3,3);

alter table RACECARS modify column LAP_EFFICIENCY DECIMAL(3,3);
alter table IDENTITY add column SNAKE_SCORE INT;
alter table IDENTITY add column USERNAME VARCHAR(14);