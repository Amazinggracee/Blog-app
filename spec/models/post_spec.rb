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
end
