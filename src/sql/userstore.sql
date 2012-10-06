-- Author:		Graeme Douglas
-- SQL script for setting up a database for storing user objects.

CREATE TABLE userstore
(
	id Integer PRIMARY KEY,
	uid TEXT,
	serialized TEXT,
	timestamp TEXT CURRENT_TIMESTAMP,
	UNIQUE (uid)
);
