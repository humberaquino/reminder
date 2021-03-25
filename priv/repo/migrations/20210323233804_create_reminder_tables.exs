defmodule Reminder.Repo.Migrations.CreateReminderTables do
  use Ecto.Migration

  def change do

    create table :reminder_groups do
      add :name, :string, null: false
      add :deleted_at, :naive_datetime

      timestamps()
    end

    create table :reminders do
      add :title, :string, null: false
      add :description, :text
      add :priority, :string
      add :due_date, :naive_datetime
      add :completed, :boolean, default: false, null: false
      add :deleted_at, :naive_datetime

      add :reminder_group_id, references(:reminder_groups), null: false

      timestamps()
    end

  end
end
