class PhotosController < ApplicationController
  respond_to :json

  def index
    if params[:album_id].nil?
      render json: {error: 'Album ID Required'}, status: :unprocessable_entity
    else
      album = Album.find(params[:album_id])
      photos_page = (params[:page].nil?) ? album.photos.page : album.photos.page(params[:page])
      photos = photos_page.map { |photo|
        photo.serializable_hash.merge(
          {'photo_count' => album.photos.count}
        )
      }
      render json: {
        photos: photos
      }, status: :ok
    end
  end

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
