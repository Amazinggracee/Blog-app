class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      # Handle successful comment creation
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      # Handle comment creation failure
      flash[:alert] = 'An error has occurred while creating the comment'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    # Debugging statement
    puts "params[:post_id]: #{params[:post_id]}"

    # Find the post associated with the provided post_id
    @post = Post.find_by(id: params[:post_id])

    # Check if the post with the given ID exists
    if @post.nil?
      flash[:alert] = 'Post not found'
      redirect_to root_path
    end
  end
end
