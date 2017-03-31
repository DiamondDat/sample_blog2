class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise    :database_authenticatable,   :registerable, :confirmable,
            :recoverable, :rememberable, :trackable,    :validatable
  has_many  :microposts, dependent: :destroy
  has_many  :likes,      dependent: :destroy
  has_many  :active_relationships,  class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many  :passive_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many  :following, through: :active_relationships,  source: :followed
  has_many  :followers, through: :passive_relationships, source: :follower
  validates :name,  presence: true, length: { minimum: 5, maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitvie: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  # Defines a proto-feed.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end


end

