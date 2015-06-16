class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = current_user.id
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information."
      redirect_to edit_user_registration_path
    end
  end
  
  def index
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :picture, :picture_cache, :email_favorites)
  end
end
