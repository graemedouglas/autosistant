-- Extra product configuration.

-- Product 4
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'wheels');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (4, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '20r');

-- Product 5
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (5, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '20r');

-- Product 6
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'windshield wipers winter');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (6, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'winter');

-- Product 7
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'windshield wipers');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (7, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'summer');

-- Product 8
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'rear drum brakes');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'rear');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (8, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'drum');

-- Product 9
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'front disc brakes');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'front');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (9, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'disc');

-- Product 10
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'front disc brakes');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'rear');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (10, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'drum');

-- Product 11
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'winch');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (11, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'heavy');

-- Product 12
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (12, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (12, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mr2');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (12, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1985');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (12, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'fenders');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (12, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'front');

-- Product 13
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (13, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (13, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mr2');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (13, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1985');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (13, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (13, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'front');

-- Product 14
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (14, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (14, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 15
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (15, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (15, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 16
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (16, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (16, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (16, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (16, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'wheels');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (16, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'stock');

-- Product 17
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (17, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (17, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (17, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (17, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');

-- Product 18
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (18, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (18, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (18, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (18, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'gas pedal');

-- Product 19
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (19, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (19, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (19, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (19, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake pedal');

-- Product 20
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (20, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (20, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (20, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (20, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'front fenders');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (20, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'front');

-- Product 21
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (21, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (21, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (21, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (21, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'floor mat');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (21, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'driver''s');

-- Product 22
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (22, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (22, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (22, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (22, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'exhaust pipe');

-- Product 23
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (23, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (23, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (23, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (23, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'disc brake pads');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (23, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'front');

-- Product 24
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (24, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (24, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (24, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (24, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'locks');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (24, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'door');

-- Product 25
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (25, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (25, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (25, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (25, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'windshield wipers');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (25, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'winter');

-- Product 26
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (26, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'honda');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (26, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'accord');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (26, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1992');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (26, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'winshield wipers');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (26, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'summer');

-- Product 27
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (27, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (27, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 28
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (28, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (28, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'air filter');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (28, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '350');

-- Product 29
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (29, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (29, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (29, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (29, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'tailgate');

-- Product 30
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (30, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (30, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (30, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (30, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'tailights');

-- Product 31
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (31, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (31, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (31, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (31, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'fuel injection');

-- Product 32
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (32, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (32, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (32, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (32, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'door handle');

-- Product 33
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (33, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (33, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (33, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (33, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'clutch pedal');

-- Product 34
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (34, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (34, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (34, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (34, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');

-- Product 35
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (35, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (35, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (35, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (35, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'Tailgate');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (35, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'Longbox');

-- Product 36
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (36, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (36, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (36, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (36, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'Clutch Pedal');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (36, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'Longbox');

-- Product 37
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (37, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'chrevrolet');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (37, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '2500HD');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (37, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1995');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (37, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'Brake Cable');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (37, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       'Longbox');

-- Product 38
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (38, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (38, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 39
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (39, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (39, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (39, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (39, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'spark plugs');

-- Product 40
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (40, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (40, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (40, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (40, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');

-- Product 41
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (41, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (41, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (41, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (41, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'ignition cables');

-- Product 42
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (42, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (42, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (42, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (42, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'distributor');

-- Product 43
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (43, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (43, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (43, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (43, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'headers');

-- Product 44
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (44, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (44, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (44, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2013');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (44, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'spark plugs');

-- Product 45
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (45, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (45, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (45, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2013');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (45, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');

-- Product 46
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (46, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (46, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (46, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2013');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (46, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'ignition cables');

-- Product 47
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (47, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (47, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (47, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2013');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (47, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'distributor');

-- Product 48
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (48, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ford');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (48, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'mustang');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (48, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2013');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (48, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'headers');

-- Product 49
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (49, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (49, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 50
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (50, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (50, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (50, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (50, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake cable');

-- Product 51
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (51, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (51, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (51, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (51, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'gas cap');

-- Product 52
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (52, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (52, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (52, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (52, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'clutch');

-- Product 53
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (53, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (53, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (53, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (53, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'radiator');

-- Product 54
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (54, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (54, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (54, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (54, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'steering wheel');

-- Product 55
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (55, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (55, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (55, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (55, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'door');

-- Product 56
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (56, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (56, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'aventador');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (56, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (56, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'limited edition driving gloves');

-- Product 57
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (57, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (57, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'murcielago');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (57, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2009');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (57, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'transmission shifter');

-- Product 58
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (58, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (58, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'murcielago');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (58, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2009');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (58, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'track tested tires');

-- Product 59
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (59, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'lamborghini');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (59, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'murcielago');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (59, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2009');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (59, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'professional helmet');

-- Product 60
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (60, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (60, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'jacket');

-- Product 61
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (61, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (61, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'collector''s jacket');

-- Product 62
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (62, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (62, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'enzo');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (62, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2003');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (62, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'driving lessons');

-- Product 63
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (63, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (63, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'enzo');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (63, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2003');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (63, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'sunglasses');

-- Product 64
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (64, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (64, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'enzo');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (64, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2003');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (64, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'formulated oil');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (64, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '1 quart');

-- Product 65
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (65, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (65, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'enzo');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (65, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2003');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (65, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'brake pad set');

-- Product 66
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (66, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (66, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '458 italia');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (66, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (66, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'seat cover');

-- Product 67
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (67, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (67, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '458 italia');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (67, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (67, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'clutch');

-- Product 68
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (68, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'ferrari');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (68, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'raceday');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (68, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       '458 italia');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (68, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '2012');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (68, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'radiator fluid');

-- Product 69
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (69, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'extroil');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (69, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       '10w30');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (69, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '1 quart');

-- Product 70
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (70, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'roadrunners');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (70, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       '10w30');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (70, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '1 quart');

-- Product 71
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (71, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'mototown');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (71, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'windshield wiper fluid');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (71, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '3 litres');
