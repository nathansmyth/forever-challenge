require 'rails_helper'

# basic API index, show, create, update, destroy
# index returns JSON of all values + total_count
# show returns data for each photo in album
# pagination max 10 items per page
# multiple photos can be added in single request
#* add videos to album, return merged data
#* photos can be added to multiple albums

RSpec.describe AlbumsController, type: :controller do
  context 'json' do
    context 'with valid attributes' do
      it 'lists the albums' do
      end

      it 'shows the album' do
      end

      it 'creates the album' do
        post :create, album: attributes_for(:album), format: :json
        expect(Album.count).to eq(1)
      end

      it 'updates the album' do
      end

      it 'destroys the album' do
      end

      it 'responds with 200' do
        post :create, album: attributes_for(:album), format: :json
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid attributes' do
      it 'does not list the albums' do
      end

      it 'does not show the album' do
      end

      it 'does not create the album' do
        post :create, album: attributes_for(:album, year: nil), format: :json
        expect(Album.count).to eq(0)
      end

      it 'does not update the album' do
      end

      it 'does not destroy the album' do
      end

      it 'responds with 400' do
        post :create, album: attributes_for(:album, year: nil), format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
