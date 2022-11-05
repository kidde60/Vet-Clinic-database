/* Populate database with sample data. 
Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
*/

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '03-2-2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '15-11-2018', 2, true, 8), ('Pikachu', '07-1-2021', 1, false, 15.04), ('Devimon', '12-5-2017', 5, true, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '08-2-2020', 0, false, -11), ('Plantmon', '15-11-2021', 2, true, -5.7), ('Squirtle', '02-4-1993', 3, false, -12.13), ('Angemon', '12-1-2005', 1, true, -45), ('Boarmon', '07-6-2005', 7, true, 20.4), ('Blossom', '13-10-1998', 3, true, 17), ('Ditto', '14-05-2022', 4, true, 20);
 
 --Insert the following data into the owners table:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

--Insert the following data into the species table:
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

--If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id=2 WHERE name LIKE '%mon';

--All other animals are Pokemon
 UPDATE animals SET species_id=1 WHERE species_id WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
--Sam Smith owns Agumon
UPDATE animals SET owner_id=1 WHERE name='Agumon';

--Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon', 'Pikachu');

--Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon', 'Plantmon');

--Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

--Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon', 'Boarmon');

--Insert the following data for vets
INSERT INTO vets(name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

--Insert the following data for specialization
INSERT INTO specializations (vets_id,species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id from species WHERE name = 'Pokemon'));
INSERT INTO specializations (vets_id,species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id from species WHERE name = 'Digimon'));
INSERT INTO specializations (vets_id,species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id from species WHERE name = 'Pokemon'));
INSERT INTO specializations (vets_id,species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id from species WHERE name = 'Digimon')); 

--Insert the following data for visits.
insert into visits
  (animal_id, vet_id, last_visit) values
  (1, 1, '24-MAY-2020'),
  (1, 3, '22-JUL-2020'),
  (2, 4, '02-FEB-2021'),
  (3, 2, '05-JAN-2020'),
  (3, 2, '08-MAR-2020'),
  (3, 2, '14-MAY-2020'),
  (4, 3, '04-MAY-2021'),
  (5, 4, '24-FEB-2021'),
  (6, 2, '21-DEC-2019'),
  (6, 1, '10-AUG-2020'),
  (6, 2, '07-APR-2021'),
  (7, 3, '29-SEP-2019'),
  (8, 4, '03-OCT-2020'),
  (8, 4, '04-NOV-2020'),
  (9, 2, '24-JAN-2019'),
  (9, 2, '15-MAY-2019'),
  (9, 2, '27-FEB-2020'),
  (9, 2, '03-AUG-2020'),
  (10, 3, '24-MAY-2020'),
  (10, 1, '11-JAN-2021')
;
