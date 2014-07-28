Sequel.migration do
  change do
    create_table(:domain_contacts) do
      primary_key :id
      String :external_id
      Integer :domain_id
      String :type
      String :name
      String :organization
      String :address
      String :city
      String :zip
      String :state
      String :country
      String :country_code
      String :phone
      String :fax
      String :email
      String :url

      DateTime :created_on
      DateTime :updated_on
    end
  end
end