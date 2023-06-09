/*Queries that provide answers to the questions from all projects.*/

-- ===================================== Part 1 =================================================================
-- Find all animals whose name ends in "mon".
	SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
	SELECT * FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
-- List the name of all animals that are neutered and have less than 3 escape attempts.
	SELECT * FROM animals WHERE neutered=true AND escape_attempts<3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
	SELECT date_of_birth FROM animals WHERE name IN('Agumon','Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
	SELECT name,escape_attempts FROM animals WHERE weight_kg >10.5;
-- Find all animals that are neutered.
	SELECT * FROM animals WHERE neutered=true;
-- Find all animals not named Gabumon.
	SELECT * FROM animals WHERE name !='Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
	SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- ====================================== Part 2 ==================================================================
-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. 
-- Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT DEL_ANIMALS;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO DEL_ANIMALS;
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg<0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS nb_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS nb_animals FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS av_weight_kg FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,SUM(escape_attempts) total_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species type,MIN(weight_kg) AS min_weight_kg, MAX(weight_kg) max_weight_kg FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species type, AVG(escape_attempts) av_escape_attempts FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

-- ====================================== Part 3 ==================================================================

-- What animals belong to Melody Pond?
SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id and o.full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals a JOIN species s ON a.species_id = s.id AND s.name='Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners o LEFT JOIN animals a ON a.owner_id = o.id;

-- How many animals are there per species?
SELECT s.name,COUNT(a.id) nb_animals FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals a JOIN owners o ON a.owner_id = o.id AND o.full_name='Jennifer Orwell' JOIN species s ON s.id = a.species_id AND s.name='Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.* FROM animals a JOIN owners o ON a.owner_id = o.id AND o.full_name='Dean Winchester' AND escape_attempts=0;

-- Who owns the most animals?
SELECT full_name,COUNT(a.id) nb_animals FROM owners o LEFT JOIN animals a ON a.owner_id = o.id GROUP BY full_name ORDER BY COUNT(a.id) DESC LIMIT 1;

-- ====================================== Part 4 ==================================================================

-- Who was the last animal seen by William Tatcher?
SELECT a.name last_animal_seen ,date_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
WHERE vt.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1; 

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT(v.animals_id)) total_seen FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
WHERE vt.name = 'Stephanie Mendez' GROUP BY vt.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name,sp.name specialties FROM vets v LEFT JOIN specializations s ON v.id = s.vets_id LEFT JOIN species sp ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name animal_visited ,date_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
WHERE vt.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name most_visited,COUNT(v.animals_id) FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
GROUP BY v.animals_id,a.name ORDER BY COUNT(v.animals_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name first_visited_animal,date_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
WHERE vt.name = 'Maisy Smith' ORDER BY date_of_visit  LIMIT 1; 

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name most_recent_visited_animal,vt.name vet_name,date_of_visit FROM animals a JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
ORDER BY date_of_visit DESC LIMIT 1; 

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) nb_visit_not_specialized FROM (SELECT vt.name,a.name animal_visited, sp.species_id vet_specialities,a.species_id animal_species,date_of_visit FROM animals a 
JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
LEFT JOIN specializations sp ON sp.vets_id=v.vets_id WHERE sp.species_id != a.species_id OR sp.species_id IS NULL) visitNonSpecialized;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT t.name,a.species_id,COUNT(a.species_id) species_count FROM animals a 
JOIN visits v ON a.id = v.animals_id JOIN vets vt ON vt.id = v.vets_id 
LEFT JOIN specializations sp ON sp.vets_id=v.vets_id  
JOIN species t ON t.id = a.species_id WHERE vt.name = 'Maisy Smith' GROUP BY a.species_id,t.name 
ORDER BY COUNT(a.species_id) DESC LIMIT 1;