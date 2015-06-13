
alter table racing_game modify column RACING_CLASS VARCHAR(2);

alter table upgrades modify column RACING_CLASS VARCHAR(2);

alter table racecars modify column RACING_CLASS VARCHAR(2);

alter table racecars add column NAME VARCHAR(40);

alter table racecars modify column RELIABILITY DECIMAL(3,3);

alter table racecars modify column LAP_EFFICIENCY DECIMAL(3,3);

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('D', 125, 20, 0.4, 0.35, 'toyota_corolla.png', 1900, 'Toyota Corolla');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('C', 140, 28, 0.45, 0.35, 'mitsubishi_eclipse.png', 9500, 'Mitsubishi Eclipse');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('C', 150, 27, 0.47, 0.45, 'tesla_roadster.png', 12000, 'Tesla Roadster');
insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('B', 200, 32, 0.4, 0.45, 'spyker_c8_aileron.png', 23500, 'Spyker C8 Aileron');


insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('B', 192, 31, 0.55, 0.42, 'stingray.png', 24500, 'Corvette Stingray');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('A', 210, 38, 0.45, 0.39, 'maserati_MC12.png', 48500, 'Maserati MC12');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('A', 213, 35, 0.48, 0.41, 'pagani_zonda.png', 52000, 'Pagani Zonda Cinque');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('A', 198, 36, 0.53, 0.42, 'porsche_911.png', 47500, 'Porsche 911');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('A', 220, 31, 0.5, 0.35, 'rolls_royce_jonckheere.png', 52500, 'Rolls Royce Jonckheere Aerodynamic');
insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 230, 44, 0.45, 0.39, 'pagani_huayra.png', 148500, 'Pagani Huayra');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 235, 47, 0.48, 0.41, 'peugeot_onyx.png', 152000, 'Peugeot Onyx');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 220, 46, 0.625, 0.42, 'porsche_918.png', 147500, 'Porsche 918');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 224, 43, 0.6, 0.45, 'saab_PhoeniX.png', 158500, 'Saab PhoeniX');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 240, 48, 0.45, 0.35, 'saleen_s7.png', 147500, 'Saleen S7');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 310, 70, 0.6, 0.45, 'egoista.png', 275000, 'Lamborghini Egoista');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 320, 60, 0.7, 0.45, 'hennessy_venom.png', 265000, 'Hennessy Venom GT');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 290, 65, 0.75, 0.5, 'koenigsegg_one_1.png', 245000, 'Koenigsegg One:1');
