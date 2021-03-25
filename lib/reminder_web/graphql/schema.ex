defmodule ReminderWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(ReminderWeb.GraphQL.Schema.Common.ContentTypes)
  import_types(ReminderWeb.GraphQL.Schema.Common.Reminder)
  import_types(ReminderWeb.GraphQL.Schema.Common.ReminderGroup)
  import_types(ReminderWeb.GraphQL.Schema.Query.ReminderGroup)
  import_types(ReminderWeb.GraphQL.Schema.Query.Reminder)
  import_types(ReminderWeb.GraphQL.Schema.Mutation.ReminderGroup)
  import_types(ReminderWeb.GraphQL.Schema.Mutation.Reminder)

  query do
    import_fields(:reminder_group_queries)
    import_fields(:reminder_queries)
  end

  mutation do
    import_fields(:reminder_group_mutations)
    import_fields(:reminder_mutations)
  end
end
