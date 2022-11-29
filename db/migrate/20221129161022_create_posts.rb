class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comment_counter, default: 0
      t.integer :like_counter, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end