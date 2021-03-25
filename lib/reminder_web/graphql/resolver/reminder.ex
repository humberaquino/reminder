defmodule ReminderWeb.GraphQL.Resolver.Reminder do
  alias Reminder.Context.Reminders

  def list(_parent, params, _resolution) do
    reminders =
      case params do
        %{group_id: group_id} ->
          Reminders.list_reminder(group_id)

        _ ->
          Reminders.list_reminder()
      end

    {:ok, reminders}
  end

  def create(_parent, %{params: params, group_id: group_id}, _resolution) do
    params = Map.put(params, :reminder_group_id, group_id)
    Reminders.create_reminder(params)
  end

  def create(_parent, %{params: params}, _resolution) do
    Reminders.create_reminder(params)
  end

  def delete(_, %{id: id}, _) do
    case Reminders.delete_reminder(id) do
      {:ok, _} ->
        {:ok, %{success: true}}

      {:error, error} ->
        {:error, error}
    end
  end

  def update(_, %{id: id, params: params}, _) do
    Reminders.update_reminder(id, params)
  end

  def move(_, %{reminder_id: reminder_id, group_id: dest_group_id}, _) do
    Reminders.move_reminder(reminder_id, dest_group_id)
  end
end
