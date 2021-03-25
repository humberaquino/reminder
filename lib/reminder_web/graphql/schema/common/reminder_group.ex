defmodule ReminderWeb.GraphQL.Schema.Common.ReminderGroup do
  use Absinthe.Schema.Notation

  input_object :reminder_group_params do
    field :name, non_null(:string)
  end

  object :reminder_group do
    field :id, non_null(:integer)
    field :name, non_null(:string)

    field :deleted_at, :naive_datetime
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end
end
