class PhotosController < ApplicationController
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: @photo, status: :created
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.permit(:name, :description, :url, :taken_at)
  end
end
