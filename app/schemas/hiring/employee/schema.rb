# frozen_string_literal: true

class Hiring::Employee::Schema < Dry::Schema::Params
  define do
    required(:name).filled(:string)
    required(:position).filled(:string)
  end
end
