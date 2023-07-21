# frozen_string_literal: true

class Hiring::Employee::Contract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:position).filled(:string)
  end
end
