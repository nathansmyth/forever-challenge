# Populate albums and photos
50.times do |album_index|
  album = Album.create(name: Faker::Lorem.word.capitalize, position: album_index)

  50.times do |photo_index|
    album.photos.create(
      name: Faker::Lorem.word.capitalize,
      description: Faker::Lorem.sentence,
      url: Faker::Avatar.image(SecureRandom.hex, '50x50', 'jpg') + '.jpg',
      taken_at: Time.now - rand(100).days
    )
  end
end
