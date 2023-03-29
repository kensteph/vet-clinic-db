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

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals DROP COLUMN  species;
ALTER TABLE animals ADD COLUMN species_id int ;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);