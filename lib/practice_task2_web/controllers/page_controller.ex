defmodule PracticeTask2Web.PageController do
  use PracticeTask2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def send_removal_notification() do
    Email.welcome_email() |> Mailer.deliver_later()
  end
end
