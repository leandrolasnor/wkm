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

    partition_days_negative = values[:partitions].find do
      (_1[:end_date].to_date - _1[:star_date].to_date).to_i.negative?
    end

    key(:partitions).failure(:before_end_date) if partition_days_negative
    key(:partitions).failure(:after_start_date) if partition_days_negative
  rescue ArgumentError
    key(:partitions).failure(:date_format_invalid)
  end
end
