# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key(:author_id) }
    it { should have_many(:comments).with_foreign_key(:author_id) }
    it { should have_many(:likes).with_foreign_key(:author_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer }
    it { should validate_numericality_of(:posts_counter).is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    context '#recent_posts' do
      it 'returns the 3 most recent posts for the user' do
        user = create(:user)
        posts = create_list(:post, 5, author: user)
        
        recent_posts = user.recent_posts

        expect(recent_posts.length).to eq(3)
        expect(recent_posts).to eq(posts.sort_by(&:created_at).reverse.take(3))
      end
    end
  end
end
