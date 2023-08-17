class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, only_integer: true }

  def recent_posts(limit: 5)  # Set a default value for the limit
    posts.order(created_at: :desc).limit(limit)
  end
end
