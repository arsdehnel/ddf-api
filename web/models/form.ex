defmodule DataDrivenFormsApi.Form do
  use DataDrivenFormsApi.Web, :model

  schema "forms" do
    field :name, :string
    field :description, :string
    field :code, :string
    has_many :fields, DataDrivenFormsApi.Field
    belongs_to :app, DataDrivenFormsApi.App

    timestamps
  end

  @required_fields ~w(name description code app_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
