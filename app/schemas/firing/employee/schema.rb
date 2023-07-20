# frozen_string_literal: true

class Firing::Employee::Schema < Dry::Schema::Params
  define do
    required(:id).filled(:integer)
  end
end
