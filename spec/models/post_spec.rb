# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:author).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(1).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer }
    it { should validate_numericality_of(:likes_counter).only_integer }
    it { should validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    let(:user) { create(:user) } # You can use FactoryBot for creating users

    context '#recent_comments' do
      it 'returns the 5 most recent comments for the post' do
        post = create(:post)
        comments = create_list(:comment, 10, post: post)
        
        recent_comments = post.recent_comments

        expect(recent_comments.length).to eq(5)
        expect(recent_comments).to eq(comments[0..4].sort_by(&:created_at).reverse)
      end
    end

    context '#post_count' do
      it 'updates the author\'s posts_counter' do
        post = create(:post, author: user)

        expect { post.save }.to change { user.reload.posts_counter }.by(1)
      end
    end
  end
end
