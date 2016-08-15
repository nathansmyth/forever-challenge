class Photo < ActiveRecord::Base
  belongs_to :album
  validates :name, presence: true
  validate :valid_url?

  private
  def valid_url?
    unless url.end_with?('jpg', 'jpeg') || url.blank?
      errors.add(:url, 'Invalid URL Entered.')
    end
  end
end
