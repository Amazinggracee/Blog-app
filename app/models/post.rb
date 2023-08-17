class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  after_save :count_posts

  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def count_posts
    author.update(posts_counter: author.posts.all.length)
  end
end