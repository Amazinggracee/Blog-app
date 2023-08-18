require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#count_comments' do
    it 'updates the post comments_counter attribute' do
      # Arrange
      user = User.create(name: 'Sam')
      post = Post.create(title: 'Hello', author: user)
      comment = Comment.new(author_id: user.id, post: post)  # Use new instead of create

      # Act
      comment.save!  # Use save! to trigger the after_save callback

      # Assert
      expect(post.reload.comments_counter).to eq(1)
    end
  end
end
