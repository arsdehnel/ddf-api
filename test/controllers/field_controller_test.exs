defmodule DataDrivenFormsApi.FieldControllerTest do
  use DataDrivenFormsApi.ConnCase

  alias DataDrivenFormsApi.Field
  @valid_attrs %{label: "some content", sort_order: 42, type: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, field_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing fields"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, field_path(conn, :new)
    assert html_response(conn, 200) =~ "New field"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, field_path(conn, :create), field: @valid_attrs
    assert redirected_to(conn) == field_path(conn, :index)
    assert Repo.get_by(Field, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, field_path(conn, :create), field: @invalid_attrs
    assert html_response(conn, 200) =~ "New field"
  end

  test "shows chosen resource", %{conn: conn} do
    field = Repo.insert! %Field{}
    conn = get conn, field_path(conn, :show, field)
    assert html_response(conn, 200) =~ "Show field"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, field_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    field = Repo.insert! %Field{}
    conn = get conn, field_path(conn, :edit, field)
    assert html_response(conn, 200) =~ "Edit field"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    field = Repo.insert! %Field{}
    conn = put conn, field_path(conn, :update, field), field: @valid_attrs
    assert redirected_to(conn) == field_path(conn, :show, field)
    assert Repo.get_by(Field, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    field = Repo.insert! %Field{}
    conn = put conn, field_path(conn, :update, field), field: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit field"
  end

  test "deletes chosen resource", %{conn: conn} do
    field = Repo.insert! %Field{}
    conn = delete conn, field_path(conn, :delete, field)
    assert redirected_to(conn) == field_path(conn, :index)
    refute Repo.get(Field, field.id)
  end
end
