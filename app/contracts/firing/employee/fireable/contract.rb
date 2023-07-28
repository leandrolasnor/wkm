# frozen_string_literal: true

class Firing::Employee::Fireable::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:id).filled(:integer)
  end

  rule(:id) do
    employee = Employee.find(value)
    fireable = !employee.vacations.exists?(
      ['? between start_date and end_date', Time.zone.today]
    )

    key(:fireable).failure(:not_fireable) unless fireable
  rescue ActiveRecord::RecordNotFound
    key(:employee).failure(:valid_identifier)
  end
end
