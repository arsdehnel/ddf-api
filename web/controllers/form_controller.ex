defmodule DataDrivenFormsApi.FormController do
  use DataDrivenFormsApi.Web, :controller

  alias DataDrivenFormsApi.Form

  plug :scrub_params, "form" when action in [:create, :update]

  def index(conn, %{"app_id" => app_id}) do
    query = from f in Form,
      where: f.app_id == ^app_id
    forms = Repo.all(query)
    render(conn, "index.html", %{forms: forms, app_id: app_id})
  end

  def new(conn, %{"app_id" => app_id}) do
    changeset = Form.changeset(%Form{})
    render(conn, "new.html", %{changeset: changeset, app_id: app_id})
  end

  def create(conn, %{"form" => form_params, "app_id" => app_id}) do
    changeset = Form.changeset(%Form{}, form_params)

    case Repo.insert(changeset) do
      {:ok, _form} ->
        conn
        |> put_flash(:info, "Form created successfully.")
        |> redirect(to: app_form_path(conn, :index, app_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "app_id" => app_id}) do
    form = Repo.get!(Form, id)
    render(conn, "show.html", %{form: form, app_id: app_id})
  end

  def edit(conn, %{"id" => id, "app_id" => app_id}) do
    form = Repo.get!(Form, id)
    changeset = Form.changeset(form)
    render(conn, "edit.html", %{form: form, changeset: changeset, app_id: app_id})
  end

  def update(conn, %{"id" => id, "app_id" => app_id, "form" => form_params}) do
    form = Repo.get!(Form, id)
    changeset = Form.changeset(form, form_params)

    case Repo.update(changeset) do
      {:ok, form} ->
        conn
        |> put_flash(:info, "Form updated successfully.")
        |> redirect(to: app_form_path(conn, :show, app_id, form))
      {:error, changeset} ->
        render(conn, "edit.html", form: form, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "app_id" => app_id}) do
    form = Repo.get!(Form, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(form)

    conn
    |> put_flash(:info, "Form deleted successfully.")
    |> redirect(to: app_form_path(conn, :index, app_id))
  end
end
