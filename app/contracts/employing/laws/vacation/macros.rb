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
    start_date = values[:start_date]
    end_date = values[:end_date]
    overlapped_start_date = employee.vacations.exists?(
      ['? between start_date and end_date', start_date]
    )
    overlapped_end_date = employee.vacations.exists?(
      ['? between start_date and end_date', end_date]
    )
    key(:overlap).failure(:overlap) if overlapped_start_date || overlapped_end_date
  end
end
