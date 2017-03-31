class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  belongs_to :parent_id, class_name: "Comment"
  has_many   :replies  , class_name: "Comment",
             foreign_key: :parent_id,
             dependent:   :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 5, maximum: 100 }
end
