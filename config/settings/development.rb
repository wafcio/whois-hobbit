SimpleConfig.for :application do
  set :database, {
    adapter: 'sqlite',
    database: File.join(Whois.root, 'db', "development.sqlite3")
  }
end
