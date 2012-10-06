-- Author:		Graeme Douglas
-- A quick script for inserting my working example database values.

-- Setup option key-value store.
INSERT INTO options (key, value) VALUES ('companyname', 'Stan''s Auto Parts');

-- Setup identifier categories.
INSERT INTO identifiercategories (name, question)
	VALUES ('called', 'What part are you looking for?');
INSERT INTO identifiercategories (name, question)
	VALUES ('year', 'What production year was this vehicle made in?');
INSERT INTO identifiercategories (name, question)
	VALUES ('make', 'What is the make of this vehicle?');
INSERT INTO identifiercategories (name, question)
	VALUES ('model', 'What is the model name of this vehicle?');
INSERT INTO identifiercategories (name, question)
	VALUES ('option', 'Is there any other important information I need?');
