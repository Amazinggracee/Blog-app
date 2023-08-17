class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  before_save :update_author_posts_counter

  validates :title, presence: true
  validates :content, presence: true

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_author_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
