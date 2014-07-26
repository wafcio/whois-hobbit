Sequel.migration do
  change do
    create_table(:domain_contacts) do
      column :id, "varchar(255)", :null=>false
      column :domain_id, "integer"
      column :type, "varchar(255)"
      column :name, "varchar(255)"
      column :organization, "varchar(255)"
      column :address, "varchar(255)"
      column :city, "varchar(255)"
      column :zip, "varchar(255)"
      column :state, "varchar(255)"
      column :country, "varchar(255)"
      column :country_code, "varchar(255)"
      column :phone, "varchar(255)"
      column :fax, "varchar(255)"
      column :email, "varchar(255)"
      column :url, "varchar(255)"
      column :created_on, "timestamp"
      column :updated_on, "timestamp"
      
      primary_key [:id]
    end
    
    create_table(:domain_nameservers) do
      primary_key :id
      column :domain_id, "integer"
      column :name, "varchar(255)"
      column :ipv4, "varchar(255)"
      column :ipv6, "varchar(255)"
    end
    
    create_table(:domain_registrars) do
      column :id, "varchar(255)", :null=>false
      column :domain_id, "integer"
      column :name, "varchar(255)"
      column :organization, "varchar(255)"
      column :url, "varchar(255)"
      
      primary_key [:id]
    end
    
    create_table(:domains) do
      primary_key :id
      column :user_id, "integer"
      column :name, "varchar(255)"
      column :server, "varchar(255)"
      column :status, "varchar(255)"
      column :is_available, "Boolean"
      column :is_registered, "Boolean"
      column :content, "text"
      column :created_on, "timestamp"
      column :updated_on, "timestamp"
      column :expires_on, "timestamp"
    end
    
    create_table(:schema_migrations) do
      column :filename, "varchar(255)", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id
      column :email, "varchar(255)"
      column :password_digest, "varchar(255)"
      column :created_at, "timestamp"
      column :updated_at, "timestamp"
    end
  end
end
