require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter' do
    user = User.new(name: 'John Doe', posts_counter: 5)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, posts_counter: 5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'John Doe', posts_counter: -1)
    expect(user).not_to be_valid
  end

  it 'is not valid with a non-integer posts_counter' do
    user = User.new(name: 'John Doe', posts_counter: 5.5)
    expect(user).not_to be_valid
  end

  it 'is valid with a zero posts_counter' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    expect(user).to be_valid
  end

  describe '#recent_posts' do
    it 'returns an empty array when the user has no posts' do
      user = User.create(name: 'Jane Smith', posts_counter: 0)
      expect(user.recent_posts).to eq([])
    end

    it 'returns the correct number of recent posts' do
      user = User.create(name: 'Alice Johnson', posts_counter: 3)
      posts = []
      3.times { posts << user.posts.create(title: 'Post Title', content: 'Post Content') }

      expect(user.recent_posts.count).to eq(3)
    end

    it 'returns posts in descending order of creation' do
      user = User.create(name: 'Bob Brown', posts_counter: 2)
      post1 = user.posts.create(title: 'Post 1', content: 'Content 1', created_at: 1.day.ago)
      post2 = user.posts.create(title: 'Post 2', content: 'Content 2', created_at: 2.days.ago)

      expect(user.recent_posts).to eq([post1, post2])
    end

    it 'returns only the specified number of recent posts' do
      user = User.create(name: 'Eve White', posts_counter: 4)
      posts = []
      5.times { posts << user.posts.create(title: 'Post Title', content: 'Post Content') }

      expect(user.recent_posts(limit: 3).count).to eq(3)
    end
  end
end
