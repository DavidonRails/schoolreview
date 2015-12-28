require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :institution do
    sequence(:name) { |n| "#{n}"+"#{Faker::University.name}"}
    description "This should be the description of the institution"
    city "#{Faker::Address.city}"
    state "#{Faker::Address.state}"
    country "#{Faker::Address.country}"
    learning_mode "Offline"
  end

  factory :user do
    sequence(:email) { |n| "n#{Faker::Internet.email}" }
    password "password"
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :admin do
      admin true
    end
  end

  factory :program do
    sequence(:title) { |n| "#{n} program" }
    level "graduate"
    association :institution
    description "This is the description of program"
    certification "non-degree"
    start_date { Faker::Date.forward(rand(40..120)) }
    end_date { Faker::Date.forward(rand(121..200)) }
    url { Faker::Internet.url }
  end

  factory :review do
    title { Faker::Lorem.sentence }
    rating { rand(0..10) }
    content "something should be here"
    association :institution
    association :program
    association :user
  end

  factory :category do
    sequence(:name) { |n| "#{n} + #{Faker::Lorem}" }
  end

  factory :skill do
    association :program
    association :user
    association :category
    sequence(:name) { |n| "#{n} + #{Faker::Lorem.sentence}" }
    points { rand(1..10) }
    description { Faker::Lorem.paragraph }
  end
end
