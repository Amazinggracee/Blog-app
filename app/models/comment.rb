class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :count_comments

  def count_comments
    post.update(comments_counter: post.comments.all.length)
  end
end

