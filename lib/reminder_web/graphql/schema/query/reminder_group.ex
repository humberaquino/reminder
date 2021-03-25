defmodule ReminderWeb.GraphQL.Schema.Query.ReminderGroup do
  use Absinthe.Schema.Notation

  alias ReminderWeb.GraphQL.Resolver

  object :reminder_group_queries do
    @desc """
    List of reminder groups
    """
    field :reminder_group_list, non_null(list_of(non_null(:reminder_group))) do
      resolve(&Resolver.ReminderGroup.list/3)
    end
  end
end
