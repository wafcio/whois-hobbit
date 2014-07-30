Sequel.migration do
  change do
    add_column :users, :github_uid, String
    
    add_index :users, :github_uid, unique: true
  end
end