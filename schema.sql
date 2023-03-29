/* Database schema to keep the structure of entire database. */

CREATE TABLE animals
(
  id int primary key GENERATED ALWAYS AS IDENTITY ,
  name varchar(100),
  date_of_birth date,
  escape_attempts int,
  neutered boolean,
  weight_kg decimal
)
-- Add a new column
ALTER TABLE animals ADD COLUMN species varchar(100);

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	full_name varchar(100),
	age int
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE species (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name varchar(100)
);