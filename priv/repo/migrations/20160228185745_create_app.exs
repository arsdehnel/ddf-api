defmodule DataDrivenFormsApi.Repo.Migrations.CreateApp do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string
      add :description, :string

      timestamps
    end

  end
end
