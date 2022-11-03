/*Queries that provide answers to the questions from all projects.
Find all animals whose name ends in "mon".
List the name of all animals born between 2016 and 2019.
List the name of all animals that are neutered and have less than 3 escape attempts.
List the date of birth of all animals named either "Agumon" or "Pikachu".
List name and escape attempts of animals that weigh more than 10.5kg
Find all animals that are neutered.
Find all animals not named Gabumon.
Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
*/

-- Find all animals whose name ends in "mon".
SELECT name from animals WHERE name like '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth >= '2016-01-01' and date_of_birth <= '2019-12-31';
 
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered = true and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name like 'Agumon' or name like 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals where neutered = true;

-- Find all animals not named Gabumon.
SELECT * from animals where name != 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals where weight_kg >= 10.4 and weight_kg <=17.3;

/*Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.*/

--start transaction
 begin transaction;

 --Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
 UPDATE animals SET species = 'digimon' where name like '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
 UPDATE animals SET species = 'pokemon' where species = '';

 --Commit the transaction.
  COMMIT;


