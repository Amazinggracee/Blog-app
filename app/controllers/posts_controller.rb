class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, comments: :author).paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end
end
