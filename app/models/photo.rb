class Photo < ActiveRecord::Base
  belongs_to :album
  validates :album, presence: true
  validates :name, presence: true
  validates :url, presence: true
  validate :valid_url?
  validate :limit_60_photos

  private
  def valid_url?
    unless url.end_with?('jpg', 'jpeg')
      @errors.add(:url, 'Invalid URL Entered.')
    end
  end
  def limit_60_photos
    if Album.find(album_id).photos.select{|a|not a._destroy}.size >= 60
      @errors.add(:photos, 'Too many photos. Already at maximum of 60.')
    end
  end
end
