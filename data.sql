/* Populate database with sample data. */
-- PART 1
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon','2020-02-03',0,true,10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Gabumon','2018-11-15',2,true,8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Pikachu','2021-01-07',1,false,15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Devimon','2017-05-12',5,true,11);

-- PART 2
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Charmander','2020-02-08',-11,false,0);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Plantmon','2021-11-15',-5.7,true,2);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Squirtle','1993-04-02',-12.13,false,3);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Angemon','2005-06-12',-45,true,1);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Boarmon','2005-06-07',20.4,true,7);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Blossom','1998-10-13',17,true,3);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Ditto','2022-05-14',22,true,4);

--PART 3
-- Insert data into owners table
INSERT INTO owners (full_name,age) VALUES('Sam Smith',34);
INSERT INTO owners (full_name,age) VALUES('Jennifer Orwell',19);
INSERT INTO owners (full_name,age) VALUES('Bob',45);
INSERT INTO owners (full_name,age) VALUES('Melody Pond',77);
INSERT INTO owners (full_name,age) VALUES('Dean Winchester',14);
INSERT INTO owners (full_name,age) VALUES('Jodie Whittaker',38);

-- Insert data into species table
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

