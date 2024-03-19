class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :trip_id
      t.text :caption, null: false

      t.timestamps
    end
  end
end
