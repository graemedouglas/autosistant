-- Author:		Graeme Douglas
-- A quick script for inserting my working example database values.

-- Setup option key-value store.
INSERT INTO options (key, value) VALUES ('companyname', 'Stan''s Auto Parts');
INSERT INTO options (key, value) VALUES ('welcomemessage',
	'Hello!  I will be your assistant for today.  How can I help you?');
INSERT INTO options (key, value) VALUES ('email_noreply',
	'example@thisisntreal.com');

-- Setup identifier categories.
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('vehiclespecific', 'Is this product vechicle specific?', 0);
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('option', 'Any general information you know about the product or the vehicle?', 1);
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('called', 'What do you call what you are looking for?', 1);
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('year', 'What production year was this vehicle made in?', 1);
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('make', 'Which company makes this product or the vechicle this product is for?', 1);
INSERT INTO identifiercategories (name, question, priority)
	VALUES ('model', 'What is the model name of this vehicle?', 1);

-- Setup question path killing.
INSERT INTO questionpath (key, value, answer)
	VALUES ((SELECT id FROM identifiercategories
			WHERE name = 'vehiclespecific'),
		(SELECT id FROM identifiercategories WHERE name = 'year'),
		'(no|n)');
INSERT INTO questionpath (key, value, answer)
	VALUES ((SELECT id FROM identifiercategories
			WHERE name = 'vehiclespecific'),
		(SELECT id FROM identifiercategories WHERE name = 'model'),
		'(no|n)');


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
INSERT INTO actionphrases(phrase, aid)
	VALUES ('help', 7);

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
--- Payment Information.
-- Payment Method.
--INSERT INTO orderquestions(priority, question, regex, label, skiphint)
--	VALUES (1000, 'Will you be paying by credit card or debit card?',
--		'(credit)|(debit|interac)', 'paymentmethod', '-1');
-- Credit card number.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1100, 'What is your credit card number?',
		'(\d{13,16})', 'pm_cc_number', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1100, 'Can I collect your credit card number?',
		'(\d{13,16})', 'pm_cc_number', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1100, 'Can I please get your credit card number?',
		'(\d{13,16})', 'pm_cc_number', '-1');
-- Credit card expiry year.
-- TODO: make this adaptable.  and not terrible.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1110, 'What is the expiry year for your credit card?',
		'(2\d{3})', 'pm_cc_expiry_year', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1110, 'In what year will your credit card expire?',
		'(2\d{3})', 'pm_cc_expiry_year', '-1');
-- Credit card expiry month.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1120, 'In which month will your credit card expire?',
		'(01|02|03|04|05|06|07|08|09|10|11|12|1|2|3|4|5|6|7|8|9|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)',
		'pm_cc_expiry_month', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1120, 'Your credit will expire in which month?',
		'(01|02|03|04|05|06|07|08|09|10|11|12|1|2|3|4|5|6|7|8|9|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)',
		'pm_cc_expiry_month', '-1');
-- Credit card CSC (Card Security Code)
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1130, 'What is the card security code for this credit card?',
		'(\d{3,4})', 'pm_cc_csc', '-1');
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (1130, 'What is the CVC2, CVV2, or CID for this credit card?',
		'(\d{3,4})', 'pm_cc_csc', '-1');
--- Email address.
INSERT INTO orderquestions(priority, question, regex, label, skiphint)
	VALUES (100000, 'What email address should I contact you by?',
		'(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})',
		'email', '-1');
