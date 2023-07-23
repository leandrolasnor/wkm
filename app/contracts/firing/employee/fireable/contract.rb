# frozen_string_literal: true

class Firing::Employee::Fireable::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:employee_id).filled(:integer)
  end

  rule(:employee_id) do
    employee = Employee.find(value)
    fireable = !employee.vacations.exists?(['? between start_date and end_date', Time.zone.now])

    key.failure(:not_fireable) unless fireable
  end
end
