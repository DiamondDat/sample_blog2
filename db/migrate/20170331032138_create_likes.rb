class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id,      null: false, unsigned: true
      t.integer :micropost_id, null: false, unsigned: true
    end
  end
end
