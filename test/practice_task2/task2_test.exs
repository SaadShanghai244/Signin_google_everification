defmodule PracticeTask2.Task2Test do
  use PracticeTask2.DataCase

  alias PracticeTask2.Task2

  describe "login" do
    alias PracticeTask2.Task2.Login

    import PracticeTask2.Task2Fixtures

    @invalid_attrs %{email: nil, password: nil}

    test "list_login/0 returns all login" do
      login = login_fixture()
      assert Task2.list_login() == [login]
    end

    test "get_login!/1 returns the login with given id" do
      login = login_fixture()
      assert Task2.get_login!(login.id) == login
    end

    test "create_login/1 with valid data creates a login" do
      valid_attrs = %{email: "some email", password: "some password"}

      assert {:ok, %Login{} = login} = Task2.create_login(valid_attrs)
      assert login.email == "some email"
      assert login.password == "some password"
    end

    test "create_login/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task2.create_login(@invalid_attrs)
    end

    test "update_login/2 with valid data updates the login" do
      login = login_fixture()
      update_attrs = %{email: "some updated email", password: "some updated password"}

      assert {:ok, %Login{} = login} = Task2.update_login(login, update_attrs)
      assert login.email == "some updated email"
      assert login.password == "some updated password"
    end

    test "update_login/2 with invalid data returns error changeset" do
      login = login_fixture()
      assert {:error, %Ecto.Changeset{}} = Task2.update_login(login, @invalid_attrs)
      assert login == Task2.get_login!(login.id)
    end

    test "delete_login/1 deletes the login" do
      login = login_fixture()
      assert {:ok, %Login{}} = Task2.delete_login(login)
      assert_raise Ecto.NoResultsError, fn -> Task2.get_login!(login.id) end
    end

    test "change_login/1 returns a login changeset" do
      login = login_fixture()
      assert %Ecto.Changeset{} = Task2.change_login(login)
    end
  end
end
