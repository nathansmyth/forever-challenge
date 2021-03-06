require 'rails_helper'

#* add videos to album, return merged data
#* photos can be added to multiple albums

RSpec.describe AlbumsController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the albums' do
        populate_albums
        get :index
        expect(response).to have_http_status(200)

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.albums.count).to eq(10)
      end

      it 'includes photo count with each album' do
        populate_albums
        get :index

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.albums[0].photo_count).to be >= 0
      end

      it 'paginates the albums, 10 at a time' do
        populate_albums
        get :index

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.albums.count).to eq(10)
      end

      it 'paginates the albums, with page index param' do
        populate_albums
        get :index, {:page => 2}

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.albums.count).to eq(5)
      end

      it 'shows the album' do
        populate_albums_photos
        get :show, {:id => 1}

        data = JSON.parse(response.body)
        expect(data['album']['photos'].count).to eq(15)
      end

      it 'creates the album' do
        post :create, album: attributes_for(:album), format: :json
        expect(Album.count).to eq(1)
      end

      it 'responds with 201' do
        post :create, album: attributes_for(:album), format: :json
        expect(response).to have_http_status(201)
      end

      it 'updates the album' do
        populate_albums
        put :update, {id: 1, album: {name: 'nathan'}}, format: :json
        expect(Album.find(1).name).to eq('nathan')
      end

      it 'destroys the album' do
        populate_albums
        how_many = Album.count

        delete :destroy, id: 1
        expect(Album.count).to eq(how_many-1)
      end
    end

    context 'with invalid attributes' do
      it 'does not show the album without id' do
        expect {
          get :show
        }.to raise_error(ActionController::UrlGenerationError)
      end

      it 'does not hold more than 60 photos' do
        over_populate_album
        expect(Album.find(1).photos.count).to be <= 60
      end

      it 'does not create the album' do
        how_many = Album.count
        post :create, album: attributes_for(:album).except(:name), format: :json
        expect(Album.count).to eq(how_many)
      end

      it 'does not update the album' do
        populate_albums
        what_name = Album.find(1).name
        put :update, {id: 1, album: {name: nil}}, format: :json
        expect(Album.find(1).name).to eq(what_name)
      end

      it 'does not destroy the album' do
        populate_albums
        how_many = Album.count
        expect {
          delete :destroy, id: 9999
        }.to raise_error(ActiveRecord::RecordNotFound)
        expect(Album.count).to eq(how_many)
      end

      it 'responds with 422' do
        post :create, album: attributes_for(:album).except(:name), format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
