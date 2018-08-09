FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password "mot_de_passe"
    password_confirmation "mot_de_passe"
    status { ["active", "inactive"].sample }
  end
end
