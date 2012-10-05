-- Author:		Graeme Douglas
-- A quick script for setting up the project databases, targetting SQLite3.

CREATE TABLE options
(
	id INTEGER PRIMARY KEY,
	key TEXT,
	value TEXT,
	UNIQUE (key)
);

CREATE TABLE actions
(
	id INTEGER PRIMARY KEY,
	description TEXT,
	code TEXT
);

CREATE TABLE actionphrases
(
	id INTEGER PRIMARY KEY,
	phrase TEXT,
	aid INTEGER,
	FOREIGN KEY(aid) REFERENCES actions(id)
);

CREATE TABLE identifiercategories
(
	id INTEGER PRIMARY KEY,
	name TEXT
);

CREATE TABLE productidentifiers
(
	id INTEGER PRIMARY KEY,
	pid INTEGER,	-- This needs to reference the product id from product table
	icid INTEGER,
	value TEXT,
	FOREIGN KEY(icid) REFERENCES identifiercategories(id)
);
