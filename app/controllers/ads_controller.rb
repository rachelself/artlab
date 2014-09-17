class AdsController < ApplicationController

  before_action :load_ad_creator, only: [:show]

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      redirect_to ad_path(@ad), notice: "Your ad was successfully published."
    else
      flash.now[:alert] = "Your ad could not be published. See below for errors."
      render :new
    end
  end

  def show
    @ad = Ad.find(params[:id])
    @user
  end

  protected

  def ad_params
    params.require(:ad).permit(:title, :description, :project_photo, :profile_image_cache, :local_only)
  end

  def load_ad_creator
    @ad = Ad.find(params[:id])
    @user = User.find_by(id: @ad.user_id)
  end

end
