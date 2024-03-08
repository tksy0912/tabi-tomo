class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :trip_id
      t.date :date, null: false, default: ""
      t.text :destination, null: false, default: ""
      t.string :transportation, null: false, default: ""
      t.boolean :is_accommodation, null: false, default: true
      t.string :accommodation_name
      
      t.timestamps
    end
  end
end
