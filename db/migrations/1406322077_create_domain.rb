Sequel.migration do
  change do
    create_table(:domains) do
      primary_key :id
      Integer :user_id
      String :name
      String :server
      String :status
      Boolean :is_available
      Boolean :is_registered
      String :content, text: true

      DateTime :created_on
      DateTime :updated_on
      DateTime :expires_on
    end
  end
end