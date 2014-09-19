class GalleriesController < ApplicationController

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.build(gallery_params)
    if @gallery.save
      redirect_to gallery_path(@gallery), notice: "#{@gallery.title} gallery has been created."
    else
      flash.now[:alert] = "Gallery could not be created. See below for errors."
      render :new
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  protected

  def gallery_params
    params.require(:gallery).permit(:title, :description)
  end

end
