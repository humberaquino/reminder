defmodule ReminderWeb.GraphQL.Resolver.ReminderGroup do
  alias Reminder.Context.ReminderGroups

  def list(_parent, _args, _resolution) do
    groups = ReminderGroups.list()
    {:ok, groups}
  end

  def create(_parent, %{params: params}, _resolution) do
    ReminderGroups.create(params)
  end

  def delete(_, %{id: id}, _) do
    case ReminderGroups.delete(id) do
      {:ok, _} ->
        {:ok, %{success: true}}

      {:error, error} ->
        {:error, error}
    end
  end

  def update(_, %{id: id, params: params}, _) do
    ReminderGroups.update(id, params)
  end

  def get(parent, _params, _resolution) do
    reminder_group = ReminderGroups.get(parent.reminder_group_id)

    {:ok, reminder_group}
  end
end
