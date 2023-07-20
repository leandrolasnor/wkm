# frozen_string_literal: true

class Promotion::Employee::Schema < Dry::Schema::Params
  define do
    required(:id).filled(:integer)
    required(:position).filled(:string)
  end
end
