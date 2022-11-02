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