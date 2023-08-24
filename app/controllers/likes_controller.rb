class LikesController < ApplicationController
#   def new
#     @like = Like.new
#   end

  def create
    # @post = Post.find(params[:post_id])
   @like = Like.new 
   @like.author_id = current_user.id
   @like.post_id = params[:post_id]
    # @like = @post.likes.new(user_id: current_user.id)  # Use user_id instead of author_id
    if @like.save
        redirect_to(request.referrer || root_path)
        #   redirect_to user_post_path(user_id: @post.author_id, id: @post.id), notice: 'Post liked successfully!'
    else
        puts @like.errors.full_messages
    #   render :new, status: 422
    end
  end
end
