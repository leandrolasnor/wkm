# frozen_string_literal: true

class Promotion::Employee::Contract < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:position).filled(:string)
  end
end
