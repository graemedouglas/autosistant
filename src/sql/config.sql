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

CREATE TABLE identifierquestions
(
	id INTEGER PRIMARY KEY,
	question TEXT,
	icid INTEGER,
	FOREIGN KEY(icid) REFERENCES identifiercategories(id)
);

CREATE TABLE identifiercategories
(
	id INTEGER PRIMARY KEY,
	name TEXT,
	priority INTEGER,
	UNIQUE (name)
);

-- Table used to change question paths based on answers given.
CREATE TABLE questionpath
(
	id INTEGER PRIMARY KEY,
	key INTEGER,
	value INTEGER,
	answer TEXT,
	FOREIGN KEY(key) REFERENCES identifiercategories(id),
	FOREIGN KEY(value) REFERENCES identifiercategories(id)
);

CREATE TABLE productidentifiers
(
	id INTEGER PRIMARY KEY,
	pid INTEGER,	-- This needs to reference the id field of product table
	icid INTEGER,
	value TEXT,
	FOREIGN KEY(icid) REFERENCES identifiercategories(id)
);

-- Order-time questions.
CREATE TABLE orderquestions
(
	id INTEGER PRIMARY KEY,	
	priority INTEGER,	-- Smaller number means higher priority.
	question TEXT,		-- The question to ask.
	regex TEXT,		-- The regex used to verify this information.
	label TEXT,		-- Order information label, like 'city'.
	skiphint TEXT,		-- TODO: Make this clear.
	UNIQUE (question)
);

-- Staged orders, to be later processed by the customer's system.
-- TODO: Move into its own database?
CREATE TABLE stagedorders
(
	id INTEGER PRIMARY KEY,	
	orderinfo TEXT
);
