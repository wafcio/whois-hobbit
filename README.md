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