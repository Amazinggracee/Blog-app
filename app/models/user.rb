class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  attribute :posts_counter, :integer, default: 0

  after_create :initialize_posts_counter

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def initialize_posts_counter
    update_columns(posts_counter: 0)
  end
end
