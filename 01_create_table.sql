DROP TABLE cats;
DROP TABLE owners;

CREATE TABLE cats (
  id INTEGER PRIMARY KEY,
  name TEXT,
  age INTEGER,
  breed TEXT
);

CREATE TABLE owners (
  id INTEGER PRIMARY KEY,
  name TEXT
);