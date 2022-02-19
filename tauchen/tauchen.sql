INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('tauchflasche', 'Kleine Tauchflasche', -1, 0, 1),
	('tauchflasche2', 'Große Tauchflasche', -1, 0, 1)
;

INSERT INTO `shops` (store, item, price) VALUES
	('LTDgasoline', 'tauchflasche', 250),
	('RobsLiquor', 'tauchflasche', 250),
	('TwentyFourSeven', 'tauchflasche', 250),
	('LTDgasoline', 'tauchflasche2', 350),
	('RobsLiquor', 'tauchflasche2', 350),
	('TwentyFourSeven', 'tauchflasche2', 350)
;
