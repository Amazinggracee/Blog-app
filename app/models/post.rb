class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', dependent: :destroy
  has_many :comments, dependent: :destroy

  after_save :update_post_counter

  def recent_comments
    Comment.order(created_at: :desc).limit(5)
  end

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
