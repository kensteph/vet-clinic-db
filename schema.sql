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

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date

CREATE TABLE vets (
	id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name varchar(100),
	age int,
	date_of_graduation date
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, 
-- and a species can have multiple vets specialized in it. 
-- Create a "join table" called specializations to handle this relationship.

CREATE TABLE specializations (
	vets_id int,
	species_id int,
	PRIMARY KEY (vets_id,species_id),
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id),
	CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and 
-- one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, 
-- it should also keep track of the date of the visit.

CREATE TABLE visits (
	date_of_visit date,
	animals_id int,
	vets_id int,
	CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
	CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);