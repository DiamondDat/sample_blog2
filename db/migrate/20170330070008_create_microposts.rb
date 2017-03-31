class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.integer    :user_id, null: false, unsigned: true
      t.text       :content
      t.string     :picture

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
