class PhotosController < ApplicationController
  respond_to :json

  def index
    if photo_params[:album_id].nil?
      render json: {error: 'Album ID Required'}, status: :unprocessable_entity
    else
      album = Album.find(photo_params[:album_id])
      photos_page = (photo_params[:page].nil?) ? album.photos.page : album.photos.page(photo_params[:page])
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

  def show
    photo = Photo.find(photo_params[:id])
    render json: photo, status: :ok
  end

  def create
    if batch_params.any?
      batch
    else
      photo = Album.find(photo_params[:album_id]).photos.new(photo_params)
      if photo.save
        render json: photo, status: :created
      else
        render json: photo.errors, status: :unprocessable_entity
      end
    end
  end

  def batch
    photos = []
    batch_params.each do | single_photo |
      photo = Album.find(single_photo[:album_id]).photos.new(single_photo)
      if photo.save
        photos << {
          result: 'success',
          photo: photo
        }
      else
        photos << {
          result: 'error',
          errors: photo.errors
        }
      end
    end
    render json: photos, status: :multi_status
  end

  private

  def photo_params
    params.permit(:id, :album_id, :name, :description, :url, :taken_at, :page)
  end

  def batch_params
    params.fetch(:photos, {})
  end
end
