# frozen_string_literal: true

class Employing::Laws::Vacation::Partitioned::Macros < Dry::Validation::Contract
  config.messages.backend = :i18n

  register_macro(:availability) do
    request_days = values[:partitions].sum { (_1[:end_date].to_date - _1[:start_date].to_date).to_i }

    employee = Employee.find(values[:employee_id])
    key(:availability).failure(:availability) if employee.vacation_days_available <= request_days
  end

  register_macro(:max_thirty_days) do
    request_days = values[:partitions].sum { (_1[:end_date].to_date - _1[:start_date].to_date).to_i }
     key(:max_thirty_days).failure(:max_thirty_days) if request_days > 30
  end

  register_macro(:overlap) do
    employee = Employee.find(values[:employee_id])
    overlaped = values[:partitions].each do
      overlapped_start_date = employee.vacations.exists?(
        ['? between start_date and end_date', _1[:start_date]]
      )

      return true if overlapped_start_date
      
      overlapped_end_date = employee.vacations.exists?(
        ['? between start_date and end_date', _1[:end_date]]
      )

      return true if overlapped_end_date
    end

    key(:overlap).failure(:overlap) if overlaped
    
    key(:overlap).failure(:overlap) if overlapped_start_date || overlapped_end_date
  end
end
