defmodule DataDrivenFormsApi.AppController do
  use DataDrivenFormsApi.Web, :controller

  alias DataDrivenFormsApi.App

  plug :scrub_params, "app" when action in [:create, :update]

  def index(conn, _params) do
    apps = Repo.all(App)
    render(conn, "index.html", apps: apps)
  end

  def new(conn, _params) do
    changeset = App.changeset(%App{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"app" => app_params}) do
    changeset = App.changeset(%App{}, app_params)

    case Repo.insert(changeset) do
      {:ok, _app} ->
        conn
        |> put_flash(:info, "App created successfully.")
        |> redirect(to: app_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    app = Repo.get!(App, id)
    render(conn, "show.html", app: app)
  end

  def edit(conn, %{"id" => id}) do
    app = Repo.get!(App, id)
    changeset = App.changeset(app)
    render(conn, "edit.html", app: app, changeset: changeset)
  end

  def update(conn, %{"id" => id, "app" => app_params}) do
    app = Repo.get!(App, id)
    changeset = App.changeset(app, app_params)

    case Repo.update(changeset) do
      {:ok, app} ->
        conn
        |> put_flash(:info, "App updated successfully.")
        |> redirect(to: app_path(conn, :show, app))
      {:error, changeset} ->
        render(conn, "edit.html", app: app, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    app = Repo.get!(App, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(app)

    conn
    |> put_flash(:info, "App deleted successfully.")
    |> redirect(to: app_path(conn, :index))
  end
end
