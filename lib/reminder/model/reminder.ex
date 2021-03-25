defmodule Reminder.Model.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias Reminder.Model.RemiderGroup

  schema "reminders" do
    field :title, :string
    field :description, :string
    field :priority, :string
    field :due_date, :naive_datetime
    field :completed, :boolean
    field :deleted_at, :naive_datetime

    belongs_to :reminder_group, RemiderGroup

    timestamps()
  end

  @required_field [
    :title
  ]

  @valid_fields [
                  :description,
                  :priority,
                  :due_date,
                  :completed,
                  :reminder_group_id
                ] ++ @required_field

  def changeset(%Reminder{} = reminder, params \\ []) do
    reminder
    |> cast(params, @valid_fields)
    |> validate_required(@required_field)
  end
end
