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
    overlapped = values[:partitions].find do
      employee.vacations.where.not(
        '? < start_date or end_date < ?',
        _1[:end_date],
        _1[:start_date]
      ).limit(1).present?
    end

    key(:overlap).failure(:overlap) if overlapped

    first = values[:partitions].first
    second = values[:partitions].second
    third = values[:partitions].third

    overlaped_first_second = !(first[:end_date] <= second[:start_date] or second[:end_date] <= first[:start_date])
    overlaped_first_third = !(first[:end_date] <= third[:start_date] or third[:end_date] <= first[:start_date])
    overlaped_second_third = !(second[:end_date] <= third[:start_date] or third[:end_date] <= second[:start_date])

    overlapped = overlaped_first_second || overlaped_first_third || overlaped_second_third

    key(:overlap).failure(:overlap) if overlapped
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
