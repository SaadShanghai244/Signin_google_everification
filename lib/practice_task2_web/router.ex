defmodule PracticeTask2Web.Router do
  use PracticeTask2Web, :router

  alias PracticeTask2.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PracticeTask2Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end
  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", PracticeTask2Web do
    pipe_through :api

    if Mix.env() == :dev do
      forward "sent/email", Bamboo.EmailPreviewPlug
    end
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    get "/verify/:id", UserController, :verify_email
    # resources "/users", UserController, except: [:new, :edit]
  end

  scope "/api/v1", PracticeTask2Web do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UserController, :show
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PracticeTask2Web.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
