require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: 'Sample Content', comments_counter: 0, likes_counter: 0)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: nil, content: 'Sample Content', comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
    end

    it 'is not valid if title exceeds 250 characters' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'A' * 251, content: 'Sample Content', comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative comments_counter' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: 'Sample Content', comments_counter: -1, likes_counter: 0)
      expect(post).not_to be_valid
    end

    it 'is not valid with a non-integer comments_counter' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: 'Sample Content', comments_counter: 5.5, likes_counter: 0)
      expect(post).not_to be_valid
    end

    it 'is not valid with a negative likes_counter' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: 'Sample Content', comments_counter: 0, likes_counter: -1)
      expect(post).not_to be_valid
    end

    it 'is not valid with a non-integer likes_counter' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: 'Sample Content', comments_counter: 0, likes_counter: 5.5)
      expect(post).not_to be_valid
    end

    it 'is not valid without content' do
      user = User.create(name: 'John Doe')
      post = user.posts.new(title: 'Sample Title', content: nil, comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
    end
  end
end
