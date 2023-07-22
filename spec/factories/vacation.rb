# frozen_string_literal: true

FactoryBot.define do
  factory :vacation do
    start_date { 14.days.from_now }
    end_date { 44.days.from_now }
    employee
  end
end
