class ChangeTripColumns < ActiveRecord::Migration[6.1]
  def change
    change_table :trips do |t|
      t.rename :departure_date, :start_date
      t.rename :return_date, :end_date
      t.change :start_date, :datetime
      t.change :end_date, :datetime
    end
  end
end
