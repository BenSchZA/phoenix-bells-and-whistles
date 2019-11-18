defmodule ExampleWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  # alias ExampleWeb.Resolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :role, :string
    field :email, :string
    # field :posts, list_of(:post) do
    #   arg :date, :date
    #   resolve &Resolvers.Content.list_posts/3
    # end
  end

  # @desc "A user contact"
  # object :contact do
  #   field :type, non_null(:contact_type)
  #   field :value, non_null(:string)
  # end


  # @desc "User contact types"
  # enum :contact_type do
  #   value :phone, as: "phone"
  #   value :email, as: "email"
  # end

  # @desc "A user contact for input"
  # input_object :contact_input do
  #   field :type, non_null(:contact_type)
  #   field :value, non_null(:string)
  # end


end
