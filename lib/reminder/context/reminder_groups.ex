defmodule Reminder.Context.ReminderGroups do
  import Ecto.Query, warn: false

  alias Reminder.Model.ReminderGroup
  alias Reminder.Repo

  def get(nil), do: nil

  def get(id) do
    from(rg in ReminderGroup, where: rg.id == ^id)
    |> where_existing()
    |> Repo.one()
  end

  def list do
    from(rg in ReminderGroup)
    |> where_existing()
    |> Repo.all()
  end

  def where_existing(query) do
    from q in query, where: is_nil(q.deleted_at)
  end

  def create(params) do
    %ReminderGroup{}
    |> ReminderGroup.changeset(params)
    |> Repo.insert()
  end

  def delete(id) do
    case get(id) do
      nil ->
        {:error, :not_found}

      group ->
        now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

        update_group(group, %{deleted_at: now})
    end
  end

  def update(id, params) do
    case get(id) do
      nil ->
        {:error, :not_found}

      group ->
        update_group(group, params)
    end
  end

  def update_group(%ReminderGroup{} = reminder_group, params) do
    reminder_group
    |> Ecto.Changeset.change(params)
    |> Repo.update()
  end
end
