defmodule ReminderWeb.GraphQL.Schema.Query.Reminder do
  use Absinthe.Schema.Notation

  alias ReminderWeb.GraphQL.Resolver

  object :reminder_queries do
    field :reminder_list, non_null(list_of(non_null(:reminder))) do
      arg(:group_id, :integer)

      resolve(&Resolver.Reminder.list/3)
    end
  end
end
