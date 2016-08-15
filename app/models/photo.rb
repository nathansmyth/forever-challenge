class Photo < ActiveRecord::Base
  belongs_to :album
  validates :name, presence: true
  validates :url, presence: true
  validate :valid_url?

  private
  def valid_url?
    unless url.end_with?('jpg', 'jpeg')
      errors.add(:url, 'Invalid URL Entered.')
    end
  end
end
