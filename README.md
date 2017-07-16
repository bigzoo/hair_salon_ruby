# hair_salon_ruby
Create an application for a hair salon. The stylists at the salon work independently, so each client will only belong to a single stylist (one stylist, many clients).

DATABASE SETUP
CREATE DATABASE hair_salon;
CREATE TABLE stylists (id serial PRIMARY KEY,name varchar );
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
