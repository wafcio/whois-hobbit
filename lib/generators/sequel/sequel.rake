require 'active_support/core_ext/string/inflections'
require 'erb'

def migration_dir
  "#{Whois.root}db/migrations"
end

def template_dir
  "#{Whois.root}lib/generators/sequel/templates"
end

def timestamp
  Time.now.to_i
end

namespace :generate do
  desc 'Generate a new migration'
  task :migration, [:name] do |t, args|
    if args[:name]
      name = args[:name]
      template = ERB.new(File.new(File.join(template_dir, 'migration.rb.erb')).read, nil, "%").result(binding)

      filename = "#{timestamp}_#{args[:name].underscore}.rb"
      File.open(File.join(migration_dir, filename), 'w') do |file|
        file.write(template)
      end
    else
      puts 'need to provide a migration name: rake db:migrate:new[name]'
    end
  end

  desc 'Generate a new model'
  task :model, [:name] do |t, args|
    if args[:name]
      # model class
      name = args[:name]
      template = ERB.new(File.new(File.join(template_dir, 'model.rb.erb')).read, nil, "%").result(binding)

      filename = "#{args[:name].underscore}.rb"
      File.open(File.join(Whois.root, 'app', 'models', filename), 'w') do |file|
        file.write(template)
      end

      # migration file
      name = args[:name]
      table_name = name.underscore.pluralize
      template = ERB.new(File.new(File.join(template_dir, 'model_migration.rb.erb')).read, nil, "%").result(binding)

      filename = "#{timestamp}_create_#{name}.rb"
      File.open(File.join(migration_dir, filename), 'w') do |file|
        file.write(template)
      end
    else
      puts 'need to provide a migration name: rake db:migrate:new[name]'
    end
  end
end