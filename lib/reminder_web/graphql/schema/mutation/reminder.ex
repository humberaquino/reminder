defmodule ReminderWeb.GraphQL.Schema.Mutation.Reminder do
  use Absinthe.Schema.Notation

  alias ReminderWeb.GraphQL.Resolver

  object :reminder_mutations do
    field :create_reminder, type: :reminder do
      arg(:group_id, :integer)
      arg(:params, non_null(:reminder_params))

      resolve(&Resolver.Reminder.create/3)
    end

    field :delete_reminder, :result do
      arg(:id, non_null(:integer))

      resolve(&Resolver.Reminder.delete/3)
    end

    field :update_reminder, type: :reminder do
      arg(:id, non_null(:integer))
      arg(:params, :reminder_params)

      resolve(&Resolver.Reminder.update/3)
    end

    field :move_reminder, type: :reminder do
      arg(:reminder_id, non_null(:integer))
      arg(:group_id, non_null(:integer))

      resolve(&Resolver.Reminder.move/3)
    end
  end
end
