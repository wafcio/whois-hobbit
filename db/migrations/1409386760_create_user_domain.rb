Sequel.migration do
  change do
    create_table(:user_domains) do
      primary_key :id

      Integer :user_id
      Integer :domain_id
    end
  end
end