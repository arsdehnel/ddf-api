defmodule DataDrivenFormsApi.FieldController do
  use DataDrivenFormsApi.Web, :controller

  alias DataDrivenFormsApi.Field

  plug :scrub_params, "field" when action in [:create, :update]

  def index(conn, %{"app_id" => app_id, "form_id" => form_id}) do
    # text conn, form_id
    query = from f in Field,
      where: f.form_id == ^form_id
    fields = Repo.all(query)
    render(conn, "index.html", %{fields: fields, app_id: app_id, form_id: form_id})
  end

  # def index(conn, _params) do
  #   fields = Repo.all(Field)
  #   render(conn, "index.html", fields: fields)
  # end

  def new(conn, %{"app_id" => app_id, "form_id" => form_id}) do
    changeset = Field.changeset(%Field{})
    render(conn, "new.html", %{changeset: changeset, app_id: app_id, form_id: form_id})
  end

  def create(conn, %{"field" => field_params, "app_id" => app_id, "form_id" => form_id}) do
    changeset = Field.changeset(%Field{}, field_params)

    case Repo.insert(changeset) do
      {:ok, _field} ->
        conn
        |> put_flash(:info, "Field created successfully.")
        |> redirect(to: app_form_field_path(conn, :index, app_id, form_id))
      {:error, changeset} ->
        render(conn, "new.html", %{changeset: changeset, app_id: app_id, form_id: form_id})
    end
  end

  def show(conn, %{"id" => id, "app_id" => app_id, "form_id" => form_id}) do
    field = Repo.get!(Field, id)
    render(conn, "show.html", %{field: field, form_id: form_id, app_id: app_id})
  end

  def edit(conn, %{"id" => id, "app_id" => app_id, "form_id" => form_id}) do
    field = Repo.get!(Field, id)
    changeset = Field.changeset(field)
    render(conn, "edit.html", %{field: field, changeset: changeset, form_id: form_id, app_id: app_id})
  end

  def update(conn, %{"id" => id, "app_id" => app_id, "form_id" => form_id, "field" => field_params}) do
    field = Repo.get!(Field, id)
    changeset = Field.changeset(field, field_params)

    case Repo.update(changeset) do
      {:ok, field} ->
        conn
        |> put_flash(:info, "Field updated successfully.")
        |> redirect(to: app_form_field_path(conn, :show, app_id, form_id, field))
      {:error, changeset} ->
        render(conn, "edit.html", field: field, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "app_id" => app_id, "form_id" => form_id}) do
    field = Repo.get!(Field, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(field)

    conn
    |> put_flash(:info, "Field deleted successfully.")
    |> redirect(to: app_form_field_path(conn, :index, app_id, form_id))
  end
end
