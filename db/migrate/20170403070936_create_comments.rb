class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text    :content
      t.integer :micropost_id
      t.integer :user_id
    end
  end
end
