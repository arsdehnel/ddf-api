ExUnit.start

Mix.Task.run "ecto.create", ~w(-r DataDrivenFormsApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r DataDrivenFormsApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(DataDrivenFormsApi.Repo)

