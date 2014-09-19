class PhotosController < ApplicationController

  def new
    @photo = Photo.new

  end

  def create

    if photo_params[:gallery_id].present?
      @gallery = Gallery.find(photo_params[:gallery_id])
      @photo = @gallery.photos.build(photo_params)

      if @photo.save
        redirect_to gallery_path(@gallery), notice: "Photos uploaded successfully."
      else
        flash.now[:alert] = "Photos could not be uploaded. Please see errors below."
        render :new
      end

    else
      flash.now[:alert] = "Photos could not be uploaded. Please see errors below."
      render :new
    end
  end

  protected

  def photo_params
    params.require(:photo).permit(:image, :caption, :gallery_id)
  end
end
