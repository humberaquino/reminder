defmodule ReminderWeb.GraphQL.Schema.Mutation.ReminderGroup do
  use Absinthe.Schema.Notation

  alias ReminderWeb.GraphQL.Resolver

  object :reminder_group_mutations do
    field :create_reminder_group, type: :reminder_group do
      arg(:params, :reminder_group_params)

      resolve(&Resolver.ReminderGroup.create/3)
    end

    field :delete_reminder_group, :result do
      arg(:id, non_null(:integer))

      resolve(&Resolver.ReminderGroup.delete/3)
    end

    field :update_reminder_group, type: :reminder_group do
      arg(:id, non_null(:integer))
      arg(:params, :reminder_group_params)

      resolve(&Resolver.ReminderGroup.update/3)
    end
  end
end
