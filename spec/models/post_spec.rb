require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'update_author_posts_counter' do
    it "updates the author's posts_counter" do
      user = User.create(name: 'John Doe')
      post = user.posts.create(title: 'Sample Title', content: 'Sample Content')

      expect do
        post.author.posts.create(title: 'Another Title', content: 'Another Content')
      end.to change { user.reload.posts_counter }.by(1)
    end
  end
end
