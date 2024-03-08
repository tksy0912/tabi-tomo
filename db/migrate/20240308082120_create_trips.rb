class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.string :title, null: false, default: ""
      t.date :departure_date, null: false, default: ""
      t.date :return_date, null: false, default: ""

      t.timestamps
    end
  end
end
