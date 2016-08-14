class Album < ActiveRecord::Base
  has_many :photos

  validates :name, presence: true
  validates :position, numericality: { only_integer: true }

  validate :valid_date

  private
  def valid_date
    if((average_date.is_a?(Date) rescue ArgumentError) == ArgumentError)
      errors.add(:average_date, 'Invalid Date Entered.')
    end
  end
end
