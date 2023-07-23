# frozen_string_literal: true

class Employing::Laws::Partitioned::Vacation::Law < Employing::Laws::Vacation::Partitioned::Macros
  params do
    required(:employee_id).value(:integer)
    required(:partitions).array(:hash) do
      required(:start_date).value(:string)
      required(:end_date).value(:string)
    end
  end

  rule(:partitions).validate(:max_thirty_days)
  rule(:employee_id, :partitions).validate(:availability)
  rule(:employee_id, :partitions).validate(:overlap)
  rule(:employee_id, :partitions).validate(:partitioned)
end
