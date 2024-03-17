class CreatePostTripTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_trip_tags do |t|
      t.references :post, null: false, foreign_key: true
      t.references :post_tag, null: false, foreign_key: true
      
      t.timestamps
    end
    # 同じタグは２回保存出来ない
    add_index :post_trip_tags, [:post_id,:post_tag_id],unique: true
  end
end
