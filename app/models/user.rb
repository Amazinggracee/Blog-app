class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  before_create :default_posts_counter

  def default_posts_counter
    posts_counter || 0
  end

  def recent_posts
    posts.order(created_at: :desc).limit(10) # Adjust the limit as needed
  end

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
