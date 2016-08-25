require 'rails_helper'
# basic API index, show, create, update, destroy
# pagination max 10 items per page

RSpec.describe PhotosController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the photos' do
      end

      it 'paginates the photos, 10 at a time' do
        populate_albums_photos
        get :index, {:album_id => 1}

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.photos.count).to eq(10)
      end

      it 'paginates the photos, with page index param' do
        populate_albums_photos
        get :index, {:album_id => 1, :page => 2}

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.photos.count).to eq(5)
      end

      it 'shows the photo' do
      end

      it 'creates the photo' do
        how_many = Photo.count
        post :create, build(:photo).attributes, format: :json
        expect(Photo.count).to eq(how_many + 1)
      end

      it 'updates the photo' do
      end

      it 'destroys the photo' do
      end

      it 'responds with 201' do
        post :create, build(:photo).attributes, format: :json
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not list the photos without album id' do
        populate_albums_photos
        get :index

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.error).to be
      end

      it 'does not paginate the photos past album count' do
        populate_albums_photos
        get :index, {:album_id => 1, :page =>100}

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.photos.count).to eq(0)
      end

      it 'does not show the photo' do
      end

      it 'does not create the photo' do
        how_many = Photo.count
        post :create, build(:photo, name: nil).attributes, format: :json
        expect(Photo.count).to eq(how_many)
      end

      it 'does not update the photo' do
      end

      it 'does not destroy the photo' do
      end

      it 'responds with 422' do
        post :create, build(:photo, name: nil).attributes, format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
