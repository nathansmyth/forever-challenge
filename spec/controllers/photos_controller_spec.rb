require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the photos, paginated 10 at a time' do
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
        populate_albums_photos
        get :show, {:id => 55}

        data = JSON.parse(response.body, object_class: OpenStruct)
        expect(data.id).to eq(55)
        expect(data.album_id).to eq(4)
      end

      it 'creates the photo' do
        how_many = Photo.count
        post :create, build(:photo).attributes, format: :json
        expect(Photo.count).to eq(how_many + 1)
      end

      it 'creates a batch of photos' do
        how_many = Photo.count
        photos = {:photos => [
          build(:photo).attributes,
          build(:photo).attributes,
          build(:photo).attributes
        ]}
        post :create, photos, format: :json
        expect(Photo.count).to eq(how_many + 3)
      end

      it 'updates the photo' do
        populate_albums_photos
        put :update, {id: 1, name: 'nathan'}, format: :json
        expect(Photo.find(1).name).to eq('nathan')
      end

      it 'destroys the photo' do
        populate_albums_photos
        how_many = Photo.count

        delete :destroy, id: 1
        expect(Photo.count).to eq(how_many-1)
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
        expect {
          get :show
        }.to raise_error(ActionController::UrlGenerationError)
      end

      it 'does not create the photo' do
        how_many = Photo.count
        post :create, build(:photo, name: nil).attributes, format: :json
        expect(Photo.count).to eq(how_many)
      end

      it 'does not create a batch of photos' do
        how_many = Photo.count
        photos = {:photos => [
          build(:photo).attributes.delete(:name),
          build(:photo).attributes.delete(:album_id),
          build(:photo).attributes
        ]}
        expect {
          post :create, photos, format: :json
        }.to raise_error(NoMethodError)
        expect(Photo.count).to eq(how_many)
      end

      it 'does not update the photo' do
        populate_albums_photos
        what_name = Photo.find(1).name
        put :update, {id: 1, photo: {name: nil}}, format: :json
        expect(Photo.find(1).name).to eq(what_name)
      end

      it 'does not destroy the photo' do
        populate_albums_photos
        how_many = Photo.count
        expect {
          delete :destroy, id: how_many + 99
        }.to raise_error(ActiveRecord::RecordNotFound)
        expect(Photo.count).to eq(how_many)
      end

      it 'responds with 422' do
        post :create, build(:photo, name: nil).attributes, format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
