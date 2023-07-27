# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { Faker::Name.first_name }
    position { Faker::Company.profession }
    hire_date { Time.zone.today }

    trait :analyst do
      position { 'Analyst' }
    end
  end
end
