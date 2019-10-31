defmodule Example.Repo.Migrations.AddUserRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "user"
    end
  end
end
