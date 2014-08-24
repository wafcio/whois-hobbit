[![Code Climate](https://codeclimate.com/github/wafcio/whois-hobbit/badges/gpa.svg)](https://codeclimate.com/github/wafcio/whois-hobbit)

# Heroku Demo

http://whois-hobbit.herokuapp.com

# How to start locally ?

1. `git clone https://github.com/wafcio/whois-hobbit`
2. `bundle install`
3. `bower install`
4. `bundle exec rackup`

# How to run on Heroku ?

1. `git clone https://github.com/wafcio/whois-hobbit`
2. `bundle install`
3. `bower install`
4. `heroku apps:create --stack cedar --buildpack git://github.com/qnyp/heroku-buildpack-ruby-bower.git#run-bower APP_NAME`
5. Create Github Application for Signing In
6. `heroku config:set GITHUB_CLIENT_ID=...`
7. `heroku config:set GITHUB_CLIENT_SECRET=...`
8. `git push heroku master`
9. `heroku run rake sq:migrate`

# Rake Tasks

<pre>
rake assets                    # Compile assets
rake clean_assets              # Clean old assets
rake clobber_assets            # Remove all assets
rake console                   # Start a console
rake generate:migration[name]  # Generate a new migration
rake generate:model[name]      # Generate a new model
rake sq:migrate                # Migrate the database through scripts in db/migrate and update db/schema.rb by invoking sq:schema:dump
rake sq:migrate:status         # Display status of migrations
rake sq:reset                  # Drops all tables and recreates the schema from db/schema.rb
rake sq:rollback[step]         # Reverts to previous schema version
rake sq:schema:drop            # Drops the database schema, using schema.rb
rake sq:schema:dump            # Dumps the schema to db/schema.db
rake sq:schema:load            # Load a schema.rb file into the database
rake sq:seed                   # Load the seed data from db/seeds.rb
rake sq:setup                  # Load the schema, and initialize with the seed data (use sq:reset to also drop the database first)
rake sq:version                # Returns current schema version
</pre>