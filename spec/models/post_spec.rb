require 'rails_helper'

RSpec.describe Post, type: :model do
  @author = User.create(name: 'James', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.',
                        posts_counter: 3)
  subject do
    Post.new(author: @author, title: 'Hello', text: 'Teacher need to get trained', comments_counter: 1,
             likes_counter: 2)
  end
  before { subject.save }

  it 'title must not be null' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not be more than 250 characters long' do
    subject.title = 'a' * 260
    expect(subject).to_not be_valid
  end

  it 'comments_counter nil must not be valid' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes_counter nil must not be valid' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter non-integer value must not be valid' do
    subject.comments_counter = 'aaa'
    expect(subject).to_not be_valid
  end

  it 'likes_counter non-integer value must not be valid' do
    subject.likes_counter = 'aaa'
    expect(subject).to_not be_valid
  end

  it 'comments_counter negative value must not be valid' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter negative value must not be valid' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return a users last 5 comment' do
    user1 = User.create(name: 'Spencer Okyere', photo: 'Link to photo', bio: 'Hello World', posts_counter: 10)
    post1 = Post.create(title: 'Random title', text: 'Hello, world', author: user1, likes_counter: 0,
                        comments_counter: 0)

    comment = Comment.create(author: user1, post: post1, text: 'Test Post')
    comment1 = Comment.create(author: user1, post: post1, text: 'Test Post')
    comment2 = Comment.create(author: user1, post: post1, text: 'Test Post')
    comment3 = Comment.create(author: user1, post: post1, text: 'Test Post')
    comment4 = Comment.create(author: user1, post: post1, text: 'Test Post')

    expect(post1.most_recent_comments.length).to eq(5)
  end
end
