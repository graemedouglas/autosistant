-- Author:		Graeme Douglas
-- A quick script for inserting my working example database values.

-- Setup option key-value store.
INSERT INTO options (key, value)
	VALUES ('companyname', 'Stan''s Auto Parts');

-- Setup identifier categories.
INSERT INTO identifiercategories (name) VALUES ('called');
INSERT INTO identifiercategories (name) VALUES ('year');
INSERT INTO identifiercategories (name) VALUES ('make');
INSERT INTO identifiercategories (name) VALUES ('model');
INSERT INTO identifiercategories (name) VALUES ('option');
