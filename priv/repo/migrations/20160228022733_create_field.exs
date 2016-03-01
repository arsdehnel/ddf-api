defmodule DataDrivenFormsApi.Repo.Migrations.CreateField do
  use Ecto.Migration

  def change do
    create table(:fields) do
      add :label, :string
      add :type, :string
      add :sort_order, :integer

      timestamps
    end

  end
end
