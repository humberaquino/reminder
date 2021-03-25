defmodule Reminder.Context.Reminders do
  import Ecto.Query, warn: false

  alias Reminder.Repo
  alias Reminder.Model.Reminder

  def get(id) do
    from(rg in Reminder, where: rg.id == ^id)
    |> where_existing()
    |> Repo.one()
  end

  def list_reminder do
    from(rg in Reminder)
    |> where_existing()
    |> Repo.all()
  end

  def list_reminder(group_id) when is_integer(group_id) do
    from(rg in Reminder)
    |> where_existing()
    |> filter_by_group(group_id)
    |> Repo.all()
  end

  defp where_existing(query) do
    from q in query, where: is_nil(q.deleted_at)
  end

  defp filter_by_group(query, group_id) do
    from(q in query, where: q.reminder_group_id == ^group_id)
  end

  def create_reminder(params) do
    %Reminder{}
    |> Reminder.changeset(params)
    |> Repo.insert()
  end

  def delete_reminder(id) do
    case get(id) do
      nil ->
        {:error, :not_found}

      reminder ->
        now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        update_reminder(reminder, %{deleted_at: now})
    end
  end

  def update_reminder(id, params) when is_integer(id) do
    case get(id) do
      nil ->
        {:error, :not_found}

      reminder ->
        update_reminder(reminder, params)
    end
  end

  def update_reminder(%Reminder{} = reminder, params) do
    reminder
    |> Ecto.Changeset.change(params)
    |> Repo.update()
  end

  def move_reminder(reminder_id, group_id) do
    update_reminder(reminder_id, %{reminder_group_id: group_id})
  end
end
