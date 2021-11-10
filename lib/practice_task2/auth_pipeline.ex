defmodule PracticeTask2.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Practice,
  module: PracticeTask2.Guardian,
  error_handler: PracticeTask2.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
