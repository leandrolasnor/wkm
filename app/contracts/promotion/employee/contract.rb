# frozen_string_literal: true

class Promotion::Employee::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:employee_id).filled(:integer)
    required(:position).filled(:string)
  end

  rule(:employee_id) do
    key.failure(:valid_identifier) unless Employee.exists?(value)
  end
end
