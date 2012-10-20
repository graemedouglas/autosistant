-- Author:		Graeme Douglas
-- A quick script for setting up the project databases, targetting SQLite3.

CREATE TABLE options
(
	id INTEGER PRIMARY KEY,
	key TEXT,
	value TEXT,
	UNIQUE (key)
);

CREATE TABLE actionphrases
(
	id INTEGER PRIMARY KEY,
	phrase TEXT,
	aid INTEGER,	--References actions.rb's Actions array keys.
	UNIQUE (phrase)
);

CREATE TABLE identifiercategories
(
	id INTEGER PRIMARY KEY,
	name TEXT,
	question TEXT,
	UNIQUE (name)
);

CREATE TABLE productidentifiers
(
	id INTEGER PRIMARY KEY,
	pid INTEGER,	-- This needs to reference the id field of product table
	icid INTEGER,
	value TEXT,
	FOREIGN KEY(icid) REFERENCES identifiercategories(id)
);
