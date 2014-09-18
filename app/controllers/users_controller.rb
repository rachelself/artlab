class UsersController < ApplicationController

  def dashboard
    render 'dashboard'
  end

  def edit
    @user = current_user
  end

  def update
    update_user_tags(tag_params)

    if current_user.update_attributes(user_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to profile_path
    else
      flash.alert = "Profile could not be updated. Please see below."
      @user = current_user
      render :edit
    end
  end

  def update_user_tags(tag_params)
    unless tag_params.empty?
      dump_tags
      tag_params.shift
      tag_params.each do |tag|
        ArtistTag.create(tag_id: tag, user_id: current_user.id)
      end
    end
  end

  def show
    @user = current_user
  end

  protected

  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :bio, :profile_image, :profile_image_cache)
  end

  def tag_params
    tag_params = params.require(:user).require(:tag_ids)
  end

  def dump_tags
    @old_tags = current_user.artist_tags

    unless @old_tags.empty?
      @old_tags.each do |t|
        t.destroy
      end
    end
  end

end
