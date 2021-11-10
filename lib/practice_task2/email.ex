defmodule PracticeTask2.Email do
  import Swoosh.Email


    # def welcome_email() do
    #   new_email(
    #     from: "me@app.com",
    #     to: "user@app.com",
    #     subject: "Welcome!",
    #     text_body: "Welcome to the app",
    #     # html_body: "<strong>Welcome to the app</strong>"
    #   )
    # base_email()
    # |> to("user@app.com")
    # |> subject("Welcome!")
    # |> text_body("Welcome to the app")
    # # |> html_body("<strong>Welcome to the app</strong>")
#     def welcome_email do
#     %Mailman.Email{
#       subject: "Hello Mailman!",
#       from: "Saad.regbits@gmail.com",
#       to: ["Saad.rehman044@gmail.com"],
#       text: "Hello Mate",
#       # html: Phoenix.View.render_to_string(MyApp.PageView,"index.html", foo: "bar")
#       }
# end

  # def base_email() do
  #   new_email(from: "me@app.com")
  #   |> cc(["sally@example.com", "james@example.com"])
  #   |> bcc(["sally@example.com", "james@example.com"])
  # end
end
