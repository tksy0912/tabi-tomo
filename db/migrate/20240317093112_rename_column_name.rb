class RenameColumnName < ActiveRecord::Migration[6.1]
  def change
    change_table :trips do |t|
      t.rename :start_date, :start_time
      t.rename :end_date, :end_time
    end
  end
end
