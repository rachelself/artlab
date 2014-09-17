class UsersController < ApplicationController

  # before_action :dump_tags, only: [:update]

  def dashboard
    render 'dashboard'
  end

  def edit
    @user = current_user
  end

  def update

    user_params = params.require(:user).permit(:first_name, :last_name, :bio, :profile_image, :profile_image_cache)
    tag_params = params.require(:user).require(:tag_ids)

    tag_params.shift
    tag_params.each do |tag|
      ArtistTag.create(tag_id: tag, user_id: current_user.id)
    end


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
    @user = current_user
  end

  protected

  # def dump_tags
  #   @old_tags = ArtistTag.find(user_id: current_user.id)
  # end

end
