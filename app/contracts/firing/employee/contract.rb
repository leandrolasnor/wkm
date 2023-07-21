# frozen_string_literal: true

class Firing::Employee::Contract < Dry::Validation::Contract
  params do
    required(:employee_id).filled(:integer)
  end

  rule(:employee_id) do
    key.failure('must be a valid registration identifier') unless Employee.exists?(value)
  end
end
