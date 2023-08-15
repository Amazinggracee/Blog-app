class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :author, foreign_key: { to_table: :users }  # Use :users, not :authors
      t.timestamps
    end
  end
end
