require 'rails_helper'

# every album has a name
# every album has 60-photo maximum
# each album's average_date field is average of all photos' taken_at values

RSpec.describe Album, type: :model do
  it 'has a name' do
    expect(Album.name).to be
  end

  it 'has a valid factory' do
    expect(build(:album)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:album, name: nil)).to_not be_valid
  end
end
