require 'rails_helper'
# basic API index, show, create, update, destroy
# pagination max 10 items per page

RSpec.describe PhotosController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the photos' do
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
      it 'does not list the photos' do
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
