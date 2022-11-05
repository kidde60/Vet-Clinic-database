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

/*Write queries (using JOIN) to answer the following questions:
What animals belong to Melody Pond?
List of all animals that are pokemon (their type is Pokemon).
List all owners and their animals, remember to include those that don't own any animal.
How many animals are there per species?
List all Digimon owned by Jennifer Orwell.
List all animals owned by Dean Winchester that haven't tried to escape.
Who owns the most animals?*/

--What animals belong to Melody Pond?
SELECT name FROM animals INNER JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals LEFT JOIN species ON animals.species_id=species.id WHERE species.name='Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners LEFT JOIN animals ON owners.id=animals.owner_id;

--How many animals are there per species?
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals a JOIN owners o ON a.owner_id=o.id JOIN species s ON a.species_id=s.id WHERE o.full_name='Jennifer Orwell' AND s.name='Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name from animals JOIN owners ON owners.id = animals.owner_id WHERE animals.escape_attempts = 0 AND animals.owner_id = 5;

--Who owns the most animals?
SELECT full_name, COUNT(owner_id) FROM owners JOIN animals on owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT (owner_id) desc limit 1;

/*Write queries to answer the following:
Who was the last animal seen by William Tatcher?
How many different animals did Stephanie Mendez see?
List all vets and their specialties, including vets with no specialties.
List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
What animal has the most visits to vets?
Who was Maisy Smith's first visit?
Details for most recent visit: animal information, vet information, and date of visit.
How many visits were with a vet that did not specialize in that animal's species?
What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT an.name, ve.name, vi.visit_date
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
WHERE ve.name = 'William Tatcher' 
ORDER BY vi.visit_date DESC LIMIT 1;

SELECT ve.name,
COUNT(an.name) AS animals_seenby_Stephanie 
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
WHERE ve.name = 'Stephanie Mendez'
GROUP BY ve.name;

SELECT DISTINCT ve.name, s.name 
FROM vets ve
LEFT JOIN specializations sp
on ve.id = sp.vets_id 
LEFT JOIN animals an 
on sp.species_id = an.species_id 
LEFT JOIN species s
ON  an.species_id = s.id 
ORDER BY ve.name;

SELECT ve.name, an.name,vi.visit_date 
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
WHERE ve.name = 'Stephanie Mendez' 
AND vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT an.name,
COUNT(vi.animal_id) AS most_number_of_visits
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
GROUP BY an.name
ORDER BY COUNT(vi.animal_id) DESC LIMIT 1;

SELECT an.name, ve.name,vi.visit_date
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
WHERE ve.name = 'Maisy Smith'
ORDER BY visit_date ASC LIMIT 1;

SELECT an.name, an.date_of_birth,an.escape_attempts,an.neutered,an.weight_kg,
ve.name,ve.age,ve.date_of_graduation,
vi.visit_date
FROM animals an
INNER JOIN visits vi
ON an.id = vi.animal_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
ORDER BY vi.visit_date DESC LIMIT 1;

SELECT ve.name,
COUNT(vi.vets_id) AS visits_counts_for_no_SPecVet
FROM species s
RIGHT JOIN specializations sp
ON s.id = sp.species_id
RIGHT JOIN vets ve
ON ve.id = sp.vets_id
RIGHT JOIN visits vi
ON ve.id = vi.vets_id
WHERE ve.name = 'Maisy Smith'
GROUP BY ve.name;

SELECT DISTINCT ve.name,an.name,
MAX(s.name) AS animal_species
FROM animals an
RIGHT JOIN visits vi
ON an.id = vi.animal_id
RIGHT JOIN species s
ON s.id = an.species_id
INNER JOIN vets ve
ON ve.id = vi.vets_id
WHERE ve.name = 'Maisy Smith' 
GROUP BY ve.name, an.name
ORDER BY an.name ASC LIMIT 1;