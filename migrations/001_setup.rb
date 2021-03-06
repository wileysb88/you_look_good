# $ sequel -m migrations/ sqlite://development.sqlite

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username
      String :password
      Boolean :logged_in
    end
    create_table(:posts) do
      primary_key :id
      Integer :poster_id
      String :name
      Text :description
      BYTEA :image
    end
  end
end
