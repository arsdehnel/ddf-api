defmodule DataDrivenFormsApi.Repo.Migrations.AddCodeToForm do
  use Ecto.Migration

  def change do
    alter table(:forms) do
      add :code, :string
    end  	
  end
end
