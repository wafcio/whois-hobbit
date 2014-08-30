Sequel.migration do
  up do
    alter_table(:domains) do
      drop_column :user_id
    end
  end

  down do
    alter_table(:domains) do
      add_column :user_id, Integer
    end
  end
end