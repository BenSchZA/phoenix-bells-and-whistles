defmodule AppWeb.Resolvers.Accounts do

  def find_user(_parent, %{id: id}, _resolution) do
    case App.Accounts.get_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}
      user ->
        {:ok, user}
    end
  end

  def create_user(_parent, args) do #, %{context: %{current_user: %{admin: true}}}
    App.Accounts.create_user(args)
  end
  def create_user(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end

end
