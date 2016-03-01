defmodule DataDrivenFormsApi.FieldTest do
  use DataDrivenFormsApi.ModelCase

  alias DataDrivenFormsApi.Field

  @valid_attrs %{label: "some content", sort_order: 42, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Field.changeset(%Field{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Field.changeset(%Field{}, @invalid_attrs)
    refute changeset.valid?
  end
end
