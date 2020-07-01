defmodule Kudzu.Users do
  import Ecto.Query, warn: false
  alias Kudzu.{Repo, Users.User}

  @type t :: %User{}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%user{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end
end
