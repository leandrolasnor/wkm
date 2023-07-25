# frozen_string_literal: true

class Firing::Employee::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:employee_id).filled(:integer)
  end

  rule(:employee_id) do
    key(:employee).failure(:valid_identifier) unless Employee.exists?(value)
  end
end
