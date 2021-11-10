defmodule PracticeTask2.Task2Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PracticeTask2.Task2` context.
  """

  @doc """
  Generate a login.
  """
  def login_fixture(attrs \\ %{}) do
    {:ok, login} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password"
      })
      |> PracticeTask2.Task2.create_login()

    login
  end
end
