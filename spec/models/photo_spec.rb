require 'rails_helper'

RSpec.describe Photo, type: :model do
  context 'with valid attributes' do
    it 'has a valid factory' do
      expect(build(:photo)).to be_valid
    end

    it 'has a name' do
      expect(build(:photo).name).to be
    end

    it 'belongs to an album' do
      expect(build(:photo).album_id).to_not be_nil
    end

    it 'has url ending with jpeg or jpg' do
      expect(build(:photo, url: 'http://domain.com/photo.jpg')).to be_valid
      expect(build(:photo, url: 'http://domain.com/photo.jpeg')).to be_valid
    end
  end
  context 'with invalid attributes' do
    it 'is invalid without a name' do
      expect(build(:photo, name: nil)).to_not be_valid
    end

    it 'is invalid without an album' do
      expect {
        build(:photo, album_id: nil).valid?
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'has url NOT ending with jpeg or jpg' do
      expect(build(:photo, url: 'http://domain.com/photo.htm')).to_not be_valid
      expect(build(:photo, url: 'http://domain.com/photo.png')).to_not be_valid
      expect(build(:photo, url: 'http://domain.com/photo.fla')).to_not be_valid
      expect(build(:photo, url: 'http://domain.com/photo.psd')).to_not be_valid
    end
  end
end
