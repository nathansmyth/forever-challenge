FactoryGirl.define do
  factory :album do
    name          { Faker::Team.state }
    position      { Faker::Number.between(1, 50) }
    average_date  { Faker::Date.between(1.year.ago, 1.month.ago) }
  end
end
