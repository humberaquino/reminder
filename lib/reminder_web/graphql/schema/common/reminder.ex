defmodule ReminderWeb.GraphQL.Schema.Common.Reminder do
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)

  alias ReminderWeb.GraphQL.Resolver

  input_object :reminder_params do
    field :title, non_null(:string)
    field :description, :string
    field :priority, :reminder_priority
    field :due_date, :naive_datetime
    field :completed, :boolean
  end

  object :reminder do
    field :id, non_null(:integer)
    field :title, non_null(:string)
    field :description, :string
    field :priority, :reminder_priority
    field :due_date, :naive_datetime
    field :completed, non_null(:boolean)
    field :reminder_group_id, :integer

    field :reminder_group, :reminder_group do
      resolve(&Resolver.ReminderGroup.get/3)
    end

    field :deleted_at, :naive_datetime
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
  end

  enum :reminder_priority do
    value(:high)
    value(:medium)
    value(:low)
  end
end
