require 'rails_helper'

RSpec.describe Album, type: :model do
  context 'with valid attributes' do
    it 'has a valid factory' do
      expect(build(:album)).to be_valid
    end

    it 'has a name' do
      expect(build(:album).name).to be
    end

    it 'has optional numeric position' do
      expect(build(:album, position: 5)).to be_valid
      expect(build(:album)).to be_valid
    end

    it 'has optional date average_date' do
      expect(build(:album, average_date: Date.new)).to be_valid
      expect(build(:album, average_date: nil)).to be_valid
    end

    it 'is valid with calculated average_date' do
      populate_albums_photos

      photo_dates = Photo.where(album_id: 1).pluck('taken_at').collect {|d| Time.parse(d.to_s).to_f }
      album_average = Date.parse(Time.at(photo_dates.reduce( :+ ) / photo_dates.count).to_s)

      expect(Album.find(1).average_date).to eq(album_average)
      expect(build(:album).average_date).to be_instance_of(Date)
    end
  end

  context 'with invalid attributes' do
    it 'is invalid without a name' do
      expect(build(:album, name: nil)).to_not be_valid
    end

    it 'is invalid with non-integer position' do
      expect(build(:album, position: 'test position')).to_not be_valid
      expect(build(:album, position: nil)).to_not be_valid
      expect(build(:album, position: Date.new)).to_not be_valid
    end

    it 'is valid with non-date average_date turned to nil' do
      expect(build(:album, average_date: 'test average_date').average_date).to be_nil
    end
  end
end
