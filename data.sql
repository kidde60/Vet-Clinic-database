/* Populate database with sample data. 
Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
*/

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '03-2-2020', 0, true, 10.23);
 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '15-11-2018', 2, true, 8), ('Pikachu', '07-1-2021', 1, false, 15.04), ('Devimon', '12-5-2017', 5, true, 11);
 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '08-2-2020', 0, false, -11), ('Plantmon', '15-11-2021', 2, true, -5.7), ('Squirtle', '02-4-1993', 3, false, -12.13), ('Angemon', '12-1-2005', 1, true, -45), ('Boarmon', '07-6-2005', 7, true, 20.4), ('Blossom', '13-10-1998', 3, true, 17), ('Ditto', '14-05-2022', 4, true, 20);
 