require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#likes_counter' do
    it 'updates the post likes_counter attribute' do
      # Arrange
      user = User.create(name: 'Sam')
      post = Post.create(title: 'Hello', author: user)
      like = Like.create(user:, post:)

      # Act
      like.like_counter

      # Assert
      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
