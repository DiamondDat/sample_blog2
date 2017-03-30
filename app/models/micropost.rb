class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 150 }
  validate  :picture_size

  private
  def picture_size
    if picture_size > 5.megabytes
      errors.add(:picture, "should be less than 5Mb.")
    end
  end
end
