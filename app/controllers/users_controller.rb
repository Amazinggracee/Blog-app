class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 10) # Adjust per_page as needed
  end

  def show
    @user = User.find(params[:id])
  end
end
