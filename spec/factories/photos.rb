FactoryGirl.define do
  factory :photo do
    name          { Faker::Name.name }
    description   { Faker::Hacker.say_something_smart }
    url           { Faker::Placeholdit.image }
    taken_at      { Faker::Date.between(1.year.ago, 1.month.ago) }
  end
end
