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
     