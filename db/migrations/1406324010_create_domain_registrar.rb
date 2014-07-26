Sequel.migration do
  change do
    create_table(:domain_registrars) do
      String :id, primary_key: true
      Integer :domain_id
      String :name
      String :organization
      String :url
    end
  end
end