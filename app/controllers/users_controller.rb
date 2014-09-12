class UsersController < ApplicationController

  def dashboard
    render 'dashboard'
  end

  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :bio)
    if current_user.update_attributes(user_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to profile_path
    else
      flash.alert = "Profile could not be updated. Please see below."
      @user = current_user
      render :edit
    end
  end

  def show

  end

end
