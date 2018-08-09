FactoryBot.define do
  factory :bill do
    start_date { Faker::Date.between(1.year.ago, 1.year.from_now) }
    end_date { Faker::Date.between(1.year.ago, 1.year.from_now) }
    usage { Faker::Number.number(3) }
    charges { Faker::Number.decimal(2) }
    status { ["unpaid", "paid"].sample }
    account
  end
end
