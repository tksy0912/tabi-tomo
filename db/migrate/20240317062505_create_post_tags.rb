class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.string :name, null: false
      
      t.timestamps
    end
    add_index :post_tags, :name, unique:true
  end
end
