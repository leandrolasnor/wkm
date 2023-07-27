# frozen_string_literal: true

class Employing::Laws::Vacation::Macros < Dry::Validation::Contract
  config.messages.backend = :i18n

  register_macro(:availability) do
    request_days = (values[:end_date].to_date - values[:start_date].to_date).to_i

    employee = Employee.includes(:vacations).find(values[:employee_id])
    key(:availability).failure(:availability) if employee.vacation_days_available < request_days
  end

  register_macro(:min_teen_days) do
    request_days = (values[:end_date].to_date - values[:start_date].to_date).to_i

    key(:min_teen_days).failure(:min_teen_days) if request_days < 10
  end

  register_macro(:overlap) do
    employee = Employee.find(values[:employee_id])
    overlapped = employee.vacations.where.not(
      '? <= start_date or end_date <= ?',
      values[:end_date],
      values[:start_date]
    ).limit(1).present?

    key(:overlap).failure(:overlap) if overlapped
  end
end
