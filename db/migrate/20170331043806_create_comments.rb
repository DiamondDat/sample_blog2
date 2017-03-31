class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text    :content
      t.integer :user_id,      null: false, unsigned: true
      t.integer :micropost_id, null: false, unsigned: true
      t.integer :parent_id,    null: false, unsigned: true

      t.timestamps
    end
  end
end
