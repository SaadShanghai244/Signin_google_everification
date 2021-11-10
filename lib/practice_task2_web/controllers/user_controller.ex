defmodule PracticeTask2Web.UserController do
  use PracticeTask2Web, :controller
  alias PracticeTask2.Guardian
  alias PracticeTask2.Accounts
  alias PracticeTask2.Accounts.User
  alias PracticeTask2.Mailer
  alias PracticeTask2.Repo
  alias PracticeTask2Web.Endpoint

  # action_fallback PracticeTask2Web.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{}=user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(%User{}) do

        body = """
        <html>
        <body>
        <a href="http://localhost:4000/api/v1/verify/#{user.id}">Click here to verify</a>
        </body>
        </html>
        """
        IO.inspect(user.email)

        Mailer.deliver_mail(user.email,body)


       IO.inspect(user)


    conn |> render("jwt.json", jwt: token)
   end
      # |> render("show.json", user: user)
  end
  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} -> user = Repo.get_by(User, email: email)
      IO.inspect(user)
      IO.inspect(Accounts.token_sign_in(email, password))
      IO.inspect(user.verification)
      if user.verification == "exist" do
        IO.inspect("Its a valid user by gmail")
        conn |> render("jwt.json", jwt: token)
        else
          IO.inspect("ajhsjacjjkans")
          conn |> render("error_view.json", jwt: token)
      end
      # IO.inspect(conn)
        _ ->
          IO.inspect(Accounts.token_sign_in(email, password))
          IO.inspect("Its entered to error body")
          conn |> render("invalid_sign_in.json",email: "email")
        # {:error, :unauthorized}
    end
    # conn |> render("jwt.json", jwt: "token")
  end



  def show(conn,  _hj ) do  # %{"id" => id}
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
    # render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  # def generate_new_account_token(%User{id: user_id}) do
  #   token = Phoenix.Token.sign(Endpoint, @account_verification_salt, user_id)
  # end
  def verify_email(conn, %{"id" => id}) do
    IO.inspect(" ++++++++ entered  ++++++++")

    data = Repo.get(User,id)

    changeset = User.update_verification_changeset(data,%{verification: "exist"})
    {:ok, user} = Repo.update(changeset)

    IO.inspect("++++++exist++++++")
    conn |> render("user.json", user: user)
  end
end
