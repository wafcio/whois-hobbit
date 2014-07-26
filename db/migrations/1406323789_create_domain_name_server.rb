Sequel.migration do
  change do
    create_table(:domain_nameservers) do
      primary_key :id
      Integer :domain_id
      String :name
      String :ipv4
      String :ipv6
    end
  end
end