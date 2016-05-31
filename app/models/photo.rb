class Photo < ActiveRecord::Base
  belongs_to :album
  validates :name, presence: true
end
