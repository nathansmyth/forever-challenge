require 'rails_helper'
# Ensure that every photo record belongs to an album,
# has a name
# and a url that ends with the string ".jpeg" or ".jpg".

RSpec.describe Photo, type: :model do
  it 'has a name' do
    expect(Photo.name).to be
  end

  it 'has a valid factory' do
    expect(build(:photo)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:photo, name: nil)).to_not be_valid
  end

  it 'belongs to an album' do
  end

  it 'has url ending with jpeg or jpg' do
  end
end
