require 'active_support/core_ext/string/inflections'

def migration_dir
  'db/migrations'
end

def run_migrations(opts = {})
  Sequel::Migrator.run(DB, migration_dir, opts)
end

def get_migrator(opts = {})
  Sequel::Migrator.migrator_class(migration_dir).new(DB, migration_dir, opts)
end

def schema_rb
  File.join(Whois.root, 'db', 'schema.rb')
end

namespace :sq do
  task :load_config do
    raise "no DB has been defined.\n Assign DB in your Rakefile or declare an :environment task and connect to your database." unless defined? DB
    ::Sequel.extension :migration
    DB.extension :schema_dumper
  end

  desc 'Migrate the database through scripts in db/migrate and update db/schema.rb by invoking sq:schema:dump.'
  task migrate: :load_config do
    run_migrations
    Rake::Task['sq:schema:dump'].invoke
    Rake::Task['sq:version'].invoke
  end

  namespace :migrate do
    desc 'Display status of migrations'
    task status: :load_config do
      migrations = get_migrator.send(:get_migration_files)
      applied_migrations = get_migrator.send(:get_applied_migrations)

      migrations.each do |migration|
        filename = File.basename(migration)
        line = applied_migrations.include?(filename) ? "   up   " : "  down  "
        line += File.basename(migration, '.rb').titleize
        puts line
      end
    end
  end

  desc 'Drops all tables and recreates the schema from db/schema.rb'
  task reset: ['sq:schema:drop', 'sq:schema:load']

  desc 'Reverts to previous schema version.  Specify the number of steps with STEP=n'
  task :rollback, [:step] => :load_config do |t, args|
    step = args[:step] ? args.step.to_i : 1
    versions = get_migrator.send(:get_applied_migrations).map(&:to_i)
    unless versions.empty?
      current_version = versions.max
      new_index = versions.index(current_version) - step
      down_version = new_index < 0 ? 0 : versions[new_index]

      puts "migrating down from version #{ current_version } to version #{down_version}"

      run_migrations(current: current_version, target: down_version)
      Rake::Task["sq:schema:dump"].invoke
    end
  end

  namespace :schema do
    desc 'Drops the database schema, using schema.rb'
    task drop: :load_config do
      begin
        eval(File.read(schema_rb)).apply(DB, :down)
      rescue => e
        puts e
      end
    end

    desc 'Dumps the schema to db/schema.db'
    task dump: :load_config do
      schema = DB.dump_schema_migration(same_db: true)
      File.open(File.join(Whois.root, 'db', 'schema.rb'), 'w') { |f| f.write(schema) }
    end

    desc 'Load a schema.rb file into the database'
    task load: :load_config do
      eval(File.read(schema_rb)).apply(DB, :up)
    end
  end

  desc 'Load the seed data from db/seeds.rb'
  task seed: :load_config do
    require File.join(Whois.root, 'db', 'seed.rb')
  end

  desc 'Load the schema, and initialize with the seed data (use sq:reset to also drop the database first)'
  task setup: ['sq:schema:load', 'sq:seed']

  desc 'Returns current schema version'
  task version: :load_config do
    puts "Current Schema Version: #{ get_migrator().applied_migrations.last.split('_').first }"
  end
end