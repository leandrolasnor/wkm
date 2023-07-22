# frozen_string_literal: true

class Scheduling::Vacation::Contract < Dry::Validation::Contract
  params do
    required(:employee_id).value(:integer)
    required(:start_date).value(:string)
    required(:end_date).value(:string)
  end

  rule(:end_date, :start_date) do
    request_days = (values[:end_date].to_date - values[:start_date].to_date).to_i
    unless request_days.positive?
      key(:start_date).failure('must be before end date')
      key(:end_date).failure('must be after start date')
    end
  rescue ArgumentError
    key(:start_date).failure('must be filled with Y-m-d date format')
    key(:end_date).failure('must be filled with Y-m-d date format')
  end

  rule(:employee_id) do
    key.failure('must be a valid registration identifier') unless Employee.exists?(value)
  end
end
