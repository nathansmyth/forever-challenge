require 'rails_helper'
# basic API index, show, create, update, destroy

RSpec.describe PhotosController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the photos' do
      end

      it 'shows the photo' do
      end

      it 'creates the photo' do
        post :create, photo: attributes_for(:photo), format: :json
        expect(Photo.count).to eq(1)
      end

      it 'updates the photo' do
      end

      it 'destroys the photo' do
      end

      it 'responds with 201' do
        post :create, photo: attributes_for(:photo), format: :json
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not list the photos' do
      end

      it 'does not show the photo' do
      end

      it 'does not create the photo' do
        post :create, photo: attributes_for(:photo, year: nil), format: :json
        expect(Photo.count).to eq(0)
      end

      it 'does not update the photo' do
      end

      it 'does not destroy the photo' do
      end

      it 'responds with 422' do
        post :create, photo: attributes_for(:photo, year: nil), format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
