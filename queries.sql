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

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction
begin transaction;
delete from animals;
--After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
ROLLBACK;

 /*Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction
*/

-- Delete all animals born after Jan 1st, 2022.
delete from animals where date_of_birth > '01-01-2022';

-- Create a savepoint for the transaction.
savepoint SP1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint.
ROLLBACK TO SP1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
 UPDATE animals SET weight_kg = weight_kg * -1 where weight_kg  < 0;

 -- Commit transaction.
 COMMIT;

/* Write queries to answer the following questions:
How many animals are there?
How many animals have never tried to escape?
What is the average weight of animals?
Who escapes the most, neutered or not neutered animals?
What is the minimum and maximum weight of each type of animal?
What is the average number of escape attempts per animal type of those born between 1990 and 2000?
*/

--How many animals are there?
SELECT COUNT(*) from animals;

--How many animals have never tried to escape?
SELECT COUNT(*) as "number of animals that have never escaped"from animals where escape_attempts = 0;

--What is the average weight of animals?
SELECT AVG(weight_kg) as "Average weight of animals" from animals;

--Who escapes the most, neutered or not neutered animals?
select neutered, sum(escape_attempts) as "Total number of escapes" from animals group by neutered;

--What is the minimum and maximum weight of each type of animal?
select min(weight_kg) as "minimum_animals_weight (kg)", max(weight_kg) as "maximum_animals_weight (kg)", species from animals group by species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select avg(escape_attempts) as "Average of Escaped Animal Per Species", species as "Type" from animals where date_of_birth between '01-JAN-1990' and '01-01-2000' group by species;
