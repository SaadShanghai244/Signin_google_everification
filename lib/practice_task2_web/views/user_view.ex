defmodule PracticeTask2Web.UserView do
  use PracticeTask2Web, :view
  alias PracticeTask2Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash
    }
  end
  def render("verify_email.json", %{user: user}) do
    %{
        verified: user.email_verified
    }
  end
  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
  def render("error_view.json", %{jwt: jwt}) do
    IO.inspect("This user is not exist")
    %{output: "This user is not exist",
      jwt: jwt}
  end
  def render("invalid_sign_in.json",%{email: email}) do
    %{
      email: "Not valid email to sign in"}
  end
end
