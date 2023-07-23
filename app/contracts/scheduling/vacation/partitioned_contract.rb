# frozen_string_literal: true

class Scheduling::Partitioned::Vacation::Contract < Dry::Validation::Contract
  params do
    required(:employee_id).value(:integer)
    required(:partitions).array(:hash) do
      required(:start_date).value(:string)
      required(:end_date).value(:string)
    end
  end

  rule(:partitions) do
    key(:partitions).failure('must have exactly three schedule item') if values[:partitions].size != 3

    requested_days = values[:partitions].sum do
      (_1[:end_date].to_date - _1[:star_date].to_date).to_i
    end

    key(:partitions).failure('Count of days greater than 30 days') requested_days > 30
  rescue ArgumentError
    key(:partitions).failure('must be filled with Y-m-d date format')
  end
end
