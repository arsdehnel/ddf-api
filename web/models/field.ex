defmodule DataDrivenFormsApi.Field do
  use DataDrivenFormsApi.Web, :model

  schema "fields" do
    field :label, :string
    field :type, :string
    field :sort_order, :integer
    belongs_to :form, DataDrivenFormsApi.Form

    timestamps
  end

  @required_fields ~w(label type sort_order form_id)
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
