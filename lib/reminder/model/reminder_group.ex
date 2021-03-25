defmodule Reminder.Model.ReminderGroup do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "reminder_groups" do
    field :name, :string
    field :deleted_at, :naive_datetime

    timestamps()
  end

  @required_field [:name]

  @valid_fields [:deleted_at] ++ @required_field

  def changeset(%ReminderGroup{} = reminder_group, params \\ []) do
    reminder_group
    |> cast(params, @valid_fields)
    |> validate_required(@required_field)
  end
end
