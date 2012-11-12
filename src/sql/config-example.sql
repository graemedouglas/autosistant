-- Author:		Graeme Douglas
-- A quick script for inserting my working example database values.

-- Setup option key-value store.
INSERT INTO options (key, value) VALUES ('companyname', 'Stan''s Auto Parts');
INSERT INTO options (key, value) VALUES ('welcomemessage',
	'Hello!  I will be your assistant for today.  How can I help you?');

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
INSERT INTO actionphrases(phrase, aid)
	VALUES ('forget', 1);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('done', 1);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('show', 2);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('list', 2);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('summarize', 4);
INSERT INTO actionphrases(phrase, aid)
	VALUES ('place', 5);

-- Configure ways of identifying first product
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'engine block');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (1, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '20r');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'make'),
	       'toyota');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'hilux');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'model'),
	       'pickup');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'year'),
	       '1980');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'called'),
	       'camshaft');
INSERT INTO productidentifiers(pid, icid, value)
	VALUES (2, (SELECT id FROM identifiercategories WHERE name = 'option'),
	       '20r');

---- Questions to be asked upon placing an order.
--- First question.
---- TODO: Replace all '' with NULLs
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (0, 'Would you like to pick up the item in store?',
		'(yes|y)|(no|n)', 'pickup?', '130|-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (0, 'Will you pick up the item in store?',
		'(yes|y)|(no|n)', 'pickup?', '130|-1');
--- Location questions.
-- Country.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (100, 'Which country do you live in?',
		'', 'country', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (100, 'Which country are you currently located in?',
		'', 'country', '-1');
-- State/city/province.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (110, 'Which state, province, or territory do you live in?',
		'', 'state', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (110, 'Which province, territory, or state are you located in?',
		'', 'state', '-1');
-- City/town/village.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (120, 'Which city, town, or village do you live in?',
		'', 'city', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (120, 'Which city, town, or village are you located in?',
		'', 'city', '-1');
-- Postal code.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (130, 'What is your postal code?',
		'(\d{5,6})|([a-z]\d[a-z]-?\d[a-z]\d)', 'postalcode', '-1');
-- Address.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (140, 'What is your address?',
		'', 'address', '-1');

