class AlbumsController < ApplicationController
  respond_to :json

  def index
    albums_page = (params[:page].nil?) ? Album.page : Album.page(params[:page])
    albums = albums_page.map { |album|
      album.serializable_hash.merge(
        {'photo_count' => album.photos.count}
      )
    }
    render json: {
      albums: albums
    }, status: :ok
  end

  def show
    album_show = Album.find(params[:id])
    album = album_show.serializable_hash.merge(
      {'photos' => album_show.photos}
    )
    render json: {
      album: album
    }
  end

  def create
    album = Album.new(album_params)
    if album.save
      render json: album, status: :created
    else
      render json: album.errors, status: :unprocessable_entity
    end
  end

  def update
    album = Album.update(params[:id], album_params)
    if album.save
      render json: album, status: :ok
    else
      render json: album.errors, status: :unprocessable_entity
    end
  end

  def destroy
    album = Album.find(params[:id])
    if album.destroy
      render json: album, status: :ok
    else
      render json: album.errors, status: :unprocessable_entity
    end
  end

  private

  def album_params
    params.require(:album).permit(:id, :name, :position, :average_date, :page)
  end
end
