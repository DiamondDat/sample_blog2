class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost,                    optional: true
  belongs_to :parent,  class_name: Comment, optional: true
  has_many   :replies, class_name: Comment,
             foreign_key: :parent_id,
             dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 5, maximum: 150}
end
