require 'rails_helper'

# every album has a name
# every album has 60-photo maximum
# each album's average_date field is average of all photos' taken_at values

RSpec.describe Album, type: :model do
  context 'with valid attributes' do
    it 'has a name' do
      expect(Album.name).to be
    end

    it 'has optional numeric position' do
      expect(build(:album, name: 'test name', position: 5)).to be_valid
      expect(build(:album, name: 'test name')).to be_valid
    end

    it 'has optional date average_date' do
      expect(build(:album, name: 'test name', average_date: Date.new)).to be_valid
      expect(build(:album, name: 'test name', average_date: nil)).to be_valid
    end

    it 'has a valid factory' do
      expect(build(:album)).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'is invalid without a name' do
      expect(build(:album, name: nil)).to_not be_valid
    end

    it 'is invalid with non-integer position' do
      expect(build(:album, name: 'test name', position: 'test position')).to_not be_valid
      expect(build(:album, name: 'test name', position: nil)).to_not be_valid
      expect(build(:album, name: 'test name', position: Date.new)).to_not be_valid
    end

    it 'is valid with non-date average_date' do
      expect(build(:album, name: 'test name', average_date: 'test average_date').average_date).to be_nil
    end
  end
end
