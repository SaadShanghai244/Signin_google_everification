defmodule PracticeTask2.Mailer do
  # use Swoosh.Mailer, otp_app: :practice_task2,
  # adapter: Swoosh.Adapters.Sendgrid,


  # api_key: "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"

  def config() do
    context = %Mailman.Context{
      config: %Mailman.SmtpConfig{
      relay: "smtp.gmail.com",
      port: 587,
      username: "Saad.regbits@gmail.com",
      password: "Shanghai@135",
      tls: :always },
      composer: %Mailman.EexComposeConfig{}
     }
  end

  def deliver_mail(to,body) do
    IO.inspect(to)
    email = %Mailman.Email{
      subject: "Hello Mailman!",
      from: "Saad.regbits@gmail.com",
      to: [to],
      cc: ["Saad@hasjh.com", "abcd@defd.com"],
      bcc: ["1234@wsd.com"],
      html: body
    }
    Mailman.deliver(email,config())
    IO.inspect(email)
    # with {:ok, _metadata} <- Mailer.deliver(email) do
    #   {:ok, email}
    # end
  end
  # Mailman.deliver(email, context)
  # @adapters %{
  #   mandrill: PracticeTask2.MandrillMailer,
  #   send_grid: PracticeTask2.SendGridMailer
  # }

  # def for(adapter \\ :mandrill) do
  #   Map.fetch!(@adapters, adapter)
  # end
end
