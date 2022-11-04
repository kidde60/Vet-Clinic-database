/* Database schema to keep the structure of entire database. 
Create a table named animals with the following columns:
id: integer
name: string
date_of_birth: date
escape_attempts: integer
neutered: boolean
weight_kg: decimal
*/

CREATE TABLE animals (
    id serial primary key NOT NULL,
    name  TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
-- Added a new column called species
ALTER TABLE animals ADD species text;

--create Owner's table 
 CREATE TABLE owners ( 
    id serial PRIMARY KEY NOT NULL, 
    full_name varchar(50) NOT NULL, 
    age INT
    );

--create species table
CREATE TABLE species ( 
    id serial PRIMARY KEY NOT NULL,
     name varchar(50) NOT NULL
     );

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT references species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT references owners(id);

--Remove column called species from animals table.
ALTER TABLE animals DROP COLUMN species;

--Create a table named vets
CREATE TABLE vets (
    id serial PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations(
    vets_id INT REFERENCES vets (id),
    species_id INT REFERENCES species (id)
    );

CREATE TABLE visits(
    vets_id INT REFERENCES vets(id),
    animal_id INT REFERENCES animals(id),
    visit_date DATE
    );

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
INSERT INTO visits(animal_id, vets_id, visit_date)
VALUES
   ((SELECT id from animals where name = 'Agumon'),(SELECT id from vets where name = 'Stephanie Mendez'),'2020-07-22'),
   ((SELECT id from animals where name = 'Gabumon'),(SELECT id from vets where name = 'Jack Harkness'),'2021-02-02'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-01-05'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-03-08'),
   ((SELECT id from animals where name = 'Pikachu'),(SELECT id from vets where name = 'Maisy Smith'),'2020-05-14'),
   ((SELECT id from animals where name = 'Devimon'),(SELECT id from vets where name = 'Stephanie Mendez'),'2021-05-04'),
   ((SELECT id from animals where name = 'Charmander'),(SELECT id from vets where name = 'Jack Harkness'),'2021-02-24'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-12-21'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'William Tatcher'),'2020-08-10'),
   ((SELECT id from animals where name = 'Plantmon'),(SELECT id from vets where name = 'Maisy Smith'),'2021-04-07'),
   ((SELECT id from animals where name = 'Squirtle'),(SELECT id from vets where name = 'Stephanie Mendez'),'2019-09-29'),
   ((SELECT id from animals where name = 'Angemon'),(SELECT id from vets where name = 'Jack Harkness'),'2020-10-03'),
   ((SELECT id from animals where name = 'Angemon'),(SELECT id from vets where name = 'Jack Harkness'),'2020-11-04'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-01-24'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2019-05-15'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2020-02-27'),
   ((SELECT id from animals where name = 'Boarmon'),(SELECT id from vets where name = 'Maisy Smith'),'2020-08-03'),
   ((SELECT id from animals where name = 'Blossom'),(SELECT id from vets where name = 'Stephanie Mendez'),'2020-05-24'),
   ((SELECT id from animals where name = 'Blossom'),(SELECT id from vets where name = 'William Tatcher'),'2021-01-11');