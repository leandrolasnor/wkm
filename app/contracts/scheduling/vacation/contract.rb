# frozen_string_literal: true

class Scheduling::Vacation::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:employee_id).value(:integer)
    required(:start_date).value(:string)
    required(:end_date).value(:string)
  end

  rule(:end_date, :start_date) do
    request_days = (values[:end_date].to_date - values[:start_date].to_date).to_i
    unless request_days.positive?
      key(:start_date).failure(:before_end_date)
      key(:end_date).failure(:after_start_date)
    end

    key(:start_date).failure(:must_be_future) if values[:start_date].to_date < Time.zone.now.to_date
    key(:end_date).failure(:must_be_future) if values[:end_date].to_date < Time.zone.now.to_date
  rescue StandardError
    key(:start_date).failure(:date_format_invalid)
    key(:end_date).failure(:date_format_invalid)
  end

  rule(:employee_id) do
    key(:employee).failure(:valid_identifier) unless Employee.exists?(value)
  end
end
