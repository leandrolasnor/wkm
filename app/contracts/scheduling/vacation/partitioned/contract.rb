# frozen_string_literal: true

class Scheduling::Vacation::Partitioned::Contract < Dry::Validation::Contract
  config.messages.backend = :i18n

  params do
    required(:employee_id).value(:integer)
    required(:partitions).array(:hash) do
      required(:start_date).value(:string)
      required(:end_date).value(:string)
    end
  end

  rule(:partitions) do
    key(:partitions).failure(:must_have_three_items) if values[:partitions].size != 3

    partition_days_invalid = values[:partitions].find do
      key(:start_date).failure(:must_be_future) if _1[:start_date].to_date <= Time.zone.today
      key(:end_date).failure(:must_be_future) if _1[:end_date].to_date <= Time.zone.today

      !(_1[:end_date].to_date - _1[:start_date].to_date).to_i.positive?
    end

    key(:start_date).failure(:before_end_date) if partition_days_invalid
    key(:end_date).failure(:after_start_date) if partition_days_invalid
  rescue StandardError
    key(:partitions).failure(:date_format_invalid)
  end
end
