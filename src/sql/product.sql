-- Author:		Graeme Douglas
-- A script to quickly setup the product table.

CREATE TABLE product
(
	id INTEGER PRIMARY KEY,
	name TEXT,
	price INTEGER,	-- Store price as integer.  Divide by 100 to get price.
	qty INTEGER
);
