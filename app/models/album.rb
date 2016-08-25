class Album < ActiveRecord::Base
  has_many :photos

  validates :name, presence: true
  validates :position, numericality: { only_integer: true }

  validate :valid_date

  def update_average_date
    photo_dates = self.photos.pluck('taken_at').collect {|d| Time.parse(d.to_s).to_f }
    self.average_date = Date.parse(Time.at(photo_dates.reduce( :+ ) / photo_dates.count).to_s)
    self.save!
  end

  private
  def valid_date
    if((average_date.is_a?(Date) rescue ArgumentError) == ArgumentError)
      errors.add(:average_date, 'Invalid Date Entered.')
    end
  end
end
