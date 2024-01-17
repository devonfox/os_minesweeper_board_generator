# Minesweeper Board Generator

This Ruby on Rails app creates randomized Minesweeper boards of custom size (x * y), stored in a PostgreSQL database for later retrieval and display.

Ruby version: *3.3.0*

## Running Locally

Make sure atleast Ruby version 3.3.0 is installed. 

```
$ ruby -v
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [x86_64-darwin22]
```

Check that Rails 7.1.2 is installed.
```
$ rails -v
Rails 7.1.2
```

To create the database:
```
$ rails db:create
```

To initialize the schema:
```
$ rails db:migrate
```

## Deployment

To deploy on Heroku, I recommend following [this guide](https://devcenter.heroku.com/articles/getting-started-with-rails7#local-setup) on the Heroku site and using Heroku CLI.
