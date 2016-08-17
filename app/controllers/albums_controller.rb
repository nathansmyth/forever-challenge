class AlbumsController < ApplicationController
  respond_to :json

  def index
    albums = Album.all.map { |album|
      album.serializable_hash.merge(
        {'photo_count' => album.photos.count}
      )
    }
    render json: {
      albums: albums
    }, status: :ok
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      render json: @album, status: :created
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :position, :average_date)
  end
end
