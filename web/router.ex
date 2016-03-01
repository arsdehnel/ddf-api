defmodule DataDrivenFormsApi.Router do
  use DataDrivenFormsApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DataDrivenFormsApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController

    # get "/fields", FieldController, :index
    resources "/apps", AppController do
      resources "/forms", FormController do 
        resources "/fields", FieldController
      end
    end
    # resources "/forms", FormController
    # resources "/fields", FieldController
  end

  # scope "/api", DataDrivenFormsApi, as: :api do
  #   pipe_through :api

  #   resources "/fields", FieldController
  # end



end
