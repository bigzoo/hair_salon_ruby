# Project Title
Create an application for a hair salon. The stylists at the salon work independently, so each client will only belong to a single stylist (one stylist, many clients).

## Getting Started
This app is built using Ruby, Sinatra and Postgress for the database.

### Prerequisites

Postgres -9.6.3
Ruby -2.2.3

### Installing

Clone the repo and open the terminal the cd into the folder.
```
cd hair_salon_ruby
```
Install all required gems
```
bundle install
```
Enter psql and set up the database. Run this commands line by line.
```
$                psql
#                CREATE DATABASE hair_salon;
#                \c hair_salon
hair_salon=#     CREATE TABLE stylists (id serial PRIMARY KEY,name varchar );
hair_salon=#     CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
hair_salon=#     CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
hair_salon=#     \q
```
You can now serve the project. ()
```
ruby app.rb
```
Open your browser and open the url "localhost:4567"

## Running all the tests

While in the project folder run rspec.
```
rspec
```

### Running tests separately

Tests are in two separate files. One containing tests for the Client class and one with tests for the Stylist class.
This will run tests for the Stylist class.
```
rspec spec/stylist_spec.rb
```
This will run tests for the Client class.
```
rspec spec/client_spec.rb
```


## Built With

* [Ruby](https://www.ruby-lang.org/en/) - The Language used.
* [Postgres](https://www.postgresql.org/) - Database System used.
* [Sinatra](http://www.sinatrarb.com/) - Web Server used.
 

## Authors

* **Chris Nyaga** - *Initial work* - [bigzoo](https://github.com/bigzoo)


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
