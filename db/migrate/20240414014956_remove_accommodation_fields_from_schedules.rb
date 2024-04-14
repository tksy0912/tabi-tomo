class RemoveAccommodationFieldsFromSchedules < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules, :is_accommodation, :boolean
    remove_column :schedules, :accommodation_name, :string
  end
end
