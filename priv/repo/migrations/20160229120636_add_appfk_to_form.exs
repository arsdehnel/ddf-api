defmodule DataDrivenFormsApi.Repo.Migrations.AddAppfkToForm do
  use Ecto.Migration

  def change do
  	alter table(:forms) do
	  add :app_id, references(:apps)
  	end
  	alter table(:fields) do
	  add :form_id, references(:forms)
  	end
  end
end
