require 'rails_helper'

RSpec.describe 'Users#shows', type: :system do
  before(:all) do
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @tom = User.create(name: 'Tom', photo: 'example.com/lilly-profile.jpg', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    @first_post = Post.create(author: @tom, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @lilly = User.create(name: 'Lilly', photo: 'https://example.com/lilly-profile.jpg', bio: 'Teacher from Poland.',
                         posts_counter: 0)
    @second_post = Post.create(author: @lilly, title: 'Hi Word!', text: 'Lets talk', comments_counter: 0,
                               likes_counter: 0)
    Comment.create(post: @first_post, author: @lilly, text: 'Hi Tom!')
    Comment.create(post: @second_post, author: @tom, text: 'Hi Lili!')
    @users = User.all
  end

  it 'I can see the user\'s username.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Tom')
  end

  it 'I can see the number of posts the user has written.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user\'s bio.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'I can see the user\'s first 3 posts.' do
    visit "/users/#{@tom.id}"
    posts = @tom.posts.order(created_at: :desc).limit(3)
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'I can see a button that lets me view all of a user\'s posts.' do
    visit "/users/#{@tom.id}"
    expect(page).to have_link('See all posts')
  end

  it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
    visit "/users/#{@tom.id}"
    posts = @tom.posts.order(created_at: :desc).limit(3)
    unless posts.nil? || posts.empty?
      click_link posts[0].title
      expect(page).to have_current_path("/users/#{@tom.id}/posts/#{posts[0].id}")
    end
  end

  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
    visit "/users/#{@tom.id}"
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{@tom.id}/posts")
  end
end
