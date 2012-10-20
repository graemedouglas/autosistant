-- Author:		Graeme Douglas
-- A quick script for inserting my working example database values.

-- Setup option key-value store.
INSERT INTO options (key, value) VALUES ('companyname', 'Stan''s Auto Parts');

-- Setup identifier categories.
INSERT INTO identifiercategories (name, question)
	VALUES ('option', 'Any general information you know about the product or the vehicle?');
INSERT INTO identifiercategories (name, question)
	VALUES ('called', 'What part are you looking for?');
INSERT INTO identifiercategories (name, question)
	VALUES ('year', 'What production year was this vehicle made in?');
INSERT INTO identifiercategories (name, question)
	VALUES ('make', 'What is the make of this vehicle?');
INSERT INTO identifiercategories (name, question)
	VALUES ('model', 'What is the model name of this vehicle?');

-- Setup the actionphrases store.
INSERT INTO actionphrases(phrase, aid)
	VALUES ('buy', 0);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('looking', 0);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('look', 0);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('interested', 0);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('price', 0);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('stock', 0);

-- Configure ways of identifying first product
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "make"),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "model"),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "model"),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "year"),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "called"),
	       'engine block');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (0, (SELECT id FROM identifiercategories WHERE name = "option"),
	       '20r');

INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "make"),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "model"),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "model"),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "year"),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "called"),
	       'camshaft');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = "option"),
	       '20r');
