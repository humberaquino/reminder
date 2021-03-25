defmodule ReminderWeb.GraphQL.Schema.Common.ContentTypes do
  use Absinthe.Schema.Notation

  object :result do
    field :success, non_null(:boolean)
    field :message, :string
  end
end
