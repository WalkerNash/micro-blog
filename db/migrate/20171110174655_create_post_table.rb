class CreatePostTable < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :body
      t.integer :user_id
    end
  end
end
