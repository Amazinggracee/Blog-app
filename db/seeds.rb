# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create users
User.create(name: 'John Doe', email: 'john@example.com', photo: 'profile.jpg', bio: 'A passionate developer')
User.create(name: 'Jane Smith', email: 'jane@example.com', photo: 'avatar.jpg', bio: 'Designer and artist')

# Create posts
Post.create(title: 'First Post', content: 'This is my first post content.', text: 'Short text description', comments_counter: 2, likes_counter: 5, author_id: 1)
Post.create(title: 'Second Post', content: 'Another post here.', text: 'More text', comments_counter: 3, likes_counter: 10, author_id: 2)

# Create comments
Comment.create(text: 'Great post!', user_id: 1, post_id: 1)
Comment.create(text: 'I agree!', user_id: 2, post_id: 1)
Comment.create(text: 'Nice work!', user_id: 1, post_id: 2)
