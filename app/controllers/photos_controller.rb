class PhotosController < ApplicationController
  def create
    @photo = Album.find(photo_params[:album_id]).photos.new(photo_params)
    if @photo.save
      render json: @photo, status: :created
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.permit(:album_id, :name, :description, :url, :taken_at)
  end
end
