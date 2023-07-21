# frozen_string_literal: true

class Promotion::Employee::Contract < Dry::Validation::Contract
  params do
    required(:employee_id).filled(:integer)
    required(:position).filled(:string)
  end

  rule(:employee_id) do
    key.failure('must be a valid registration identifier') unless Employee.exists?(value)
  end
end
