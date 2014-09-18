class AdsController < ApplicationController

  before_action :load_ad_creator, only: [:show]

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)

    if @ad.save
      create_ad_tags(tag_params)
      redirect_to ad_path(@ad), notice: "Your ad was successfully published."
    else
      flash.now[:alert] = "Your ad could not be published. See below for errors."
      render :new
    end
  end

  def create_ad_tags(tag_params)
    tag_params.shift
    tag_params.each do |tag|
      AdTag.create(tag_id: tag, ad_id: @ad.id)
    end
  end

  def show
    @ad = Ad.find(params[:id])
    @user
  end

  def edit

    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])

    if params[:remove_project_photo].present?
      delete_photo
    end

    if @ad.update_attributes(ad_params)
      flash[:notice] = "Your ad was updated successfully."
      redirect_to ad_path(@ad)
    else
      flash.alert = "Your ad could not be updated. See below for errors."
      render :edit
    end
  end

  protected

  def delete_photo
    @ad.remove_project_photo!
    @ad.save
  end

  def ad_params
    params.require(:ad).permit(:title, :description, :project_photo, :project_photo_cache, :local_only, :remove_project_photo)
  end

  def tag_params
    params.require(:ad).permit(:tag_ids)
  end

  def load_ad_creator
    @ad = Ad.find(params[:id])
    @user = User.find_by(id: @ad.user_id)
  end

end
