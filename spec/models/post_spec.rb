require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) do
    User.create(name: 'Amarachi', photo: 'Link to photo', bio: 'Hello World', posts_counter: 10)
  end

  subject do
    Post.new(
      author: user1,
      title: 'Hello',
      text: 'Teacher needs to get trained',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    subject.title = 'a' * 260
    expect(subject).not_to be_valid
  end

  it 'is not valid with nil comments_counter' do
    subject.comments_counter = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with nil likes_counter' do
    subject.likes_counter = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with non-integer comments_counter' do
    subject.comments_counter = 'aaa'
    expect(subject).not_to be_valid
  end

  it 'is not valid with non-integer likes_counter' do
    subject.likes_counter = 'aaa'
    expect(subject).not_to be_valid
  end

  it 'is not valid with negative comments_counter' do
    subject.comments_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is not valid with negative likes_counter' do
    subject.likes_counter = -1
    expect(subject).not_to be_valid
  end

  it 'returns a user\'s last 5 comments' do
    post1 = Post.create(
      title: 'Random title',
      text: 'Hello, world',
      author: user1,
      likes_counter: 0,
      comments_counter: 0
    )

    5.times do
      Comment.create(author: user1, post: post1, text: 'Test Post')
    end

    expect(post1.most_recent_comments.length).to eq(5)
  end
end
