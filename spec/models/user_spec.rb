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
end
