# frozen_string_literal: true

class Firing::Employee::Contract < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
  end
end
