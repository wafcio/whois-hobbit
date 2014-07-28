Sequel.migration do
  change do
    create_table(:domain_registrars) do
      primary_key :id
      String :external_id
      Integer :domain_id
      String :name
      String :organization
      String :url
    end
  end
end