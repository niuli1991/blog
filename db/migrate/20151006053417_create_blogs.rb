class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.text :content
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
