class SchemaLoad
  def initialize
    Sequel.extension :migration
  end

  def perform
    drop_schema
    load_schema
    reset_dataset
    self
  end

  private

  def reset_dataset
    User.set_dataset :users
    Domain.set_dataset :domains
  end

  def drop_schema
    begin
      eval(File.read(schema_rb)).apply(DB, :down)
    rescue => e
      puts e
    end
  end

  def load_schema
    eval(File.read(schema_rb)).apply(DB, :up)
  end

  def schema_rb
    File.join(Whois.root, 'db', 'schema.rb')
  end
end