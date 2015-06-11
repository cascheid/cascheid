
alter table racing_game modify column RACING_CLASS VARCHAR(2);

alter table upgrades modify column RACING_CLASS VARCHAR(2);

alter table racecars modify column RACING_CLASS VARCHAR(2);

alter table racecars add column NAME VARCHAR(30);

update racecars set model='mclaren_p1.png', name='McLaren P1' where car_id=6;

update racecars set model='koenigsegg_CCX.png', name='Koenigsegg CCX' where car_id=12;

update racecars set model='pagani_huayra.png', name='Pagani Huayra' where car_id=18;

update racecars set model='bugatti_veyron.png', name='Bugatti Veyron' where car_id=24;

update racecars set model='pagani_zonda.png', name='Pagani Zonda Cinque' where car_id=30;

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('S', 250, 40, 0.55, 0.35, 'maserati_MC12.png', 110000, 'Maserati MC12'); 

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 320, 60, 0.75, 0.40, 'laferrari.png', 450000, 'Ferrari Laferrari'); 

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 300, 70, 0.75, 0.50, 'egoista.png', 520000, 'Lamborghini Egoista');

insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 310, 65, 0.6, 0.45, 'koenigsegg_one_1.png', 415000, 'Koenigsegg One:1');
insert into racecars (RACING_CLASS, TOP_SPEED, ACCELERATION, RELIABILITY, LAP_EFFICIENCY, MODEL, PRICE, NAME) 
VALUES ('SS', 280, 75, 0.65, 0.45, 'hennessy_venom.png', 475000, 'Hennessy Venom'); 