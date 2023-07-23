# frozen_string_literal: true

class Employing::Laws::Partitioned::Vacation::Macros < Dry::Validation::Contract
  config.messages.backend = :i18n

  register_macro(:availability) do
    request_days = values[:partitions].sum { (_1[:end_date].to_date - _1[:start_date].to_date).to_i }

    employee = Employee.find(values[:employee_id])
    key(:availability).failure(:availability) if employee.vacation_days_available < request_days
  rescue ActiveRecord::RecordNotFound
    key(:employee_id).failure(:valid_identifier)
  end

  register_macro(:max_thirty_days) do
    request_days = values[:partitions].sum { (_1[:end_date].to_date - _1[:start_date].to_date).to_i }
    key(:max_thirty_days).failure(:period_greater_than_thrity) if request_days > 30
  end

  register_macro(:overlap) do
    employee = Employee.find(values[:employee_id])
    overlaped = values[:partitions].find do
      overlapped_start_date = employee.vacations.exists?(
        ['? between start_date and end_date', _1[:start_date]]
      )

      overlapped_end_date = employee.vacations.exists?(
        ['? between start_date and end_date', _1[:end_date]]
      )

      overlapped_start_date || overlapped_end_date
    end

    key(:overlap).failure(:overlap) if overlaped

    first = values[:partitions].first
    second = values[:partitions].second
    third = values[:partitions].third

    first_with_second_overlaped_start_date = first[:start_date] > second[:start_date] && first[:start_date] < second[:end_date]
    first_with_second_overlaped_end_date = first[:end_date] < second[:end_date] && first[:end_date] > second[:start_date]
    overlaped_first_second = first_with_second_overlaped_start_date || first_with_second_overlaped_end_date

    first_with_third_overlaped_start_date = first[:start_date] > third[:start_date] && first[:start_date] < third[:end_date]
    first_with_third_overlaped_end_date = first[:end_date] < third[:end_date] && first[:end_date] > third[:start_date]
    overlaped_first_third = first_with_third_overlaped_start_date || first_with_third_overlaped_end_date

    second_with_third_overlaped_start_date = second[:start_date] > third[:start_date] && second[:start_date] < third[:end_date]
    second_with_third_overlaped_end_date = second[:end_date] < third[:end_date] && second[:end_date] > third[:start_date]
    overlaped_second_third = second_with_third_overlaped_start_date || second_with_third_overlaped_end_date

    overlaped = overlaped_first_second || overlaped_first_third || overlaped_second_third

    key(:overlap).failure(:overlap) if overlaped
  rescue ActiveRecord::RecordNotFound
    key(:employee_id).failure(:valid_identifier)
  end

  register_macro(:partitioning) do
    first = values[:partitions].first
    second = values[:partitions].second
    third = values[:partitions].third

    first_request_days = (first[:end_date].to_date - first[:start_date].to_date).to_i
    second_request_days = (second[:end_date].to_date - second[:start_date].to_date).to_i
    third_request_days = (third[:end_date].to_date - third[:start_date].to_date).to_i

    key(:partitioning).failure(:min_fourteen_request_days) if first_request_days < 14
    key(:partitioning).failure(:min_five_request_days) if second_request_days < 5
    key(:partitioning).failure(:min_five_request_days) if third_request_days < 5
  end
end
