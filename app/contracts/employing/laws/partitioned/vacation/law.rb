# frozen_string_literal: true

class Employing::Laws::Partitioned::Vacation::Law < Employing::Laws::Partitioned::Vacation::Macros
  params do
    required(:employee_id).value(:integer)
    required(:partitions).array(:hash) do
      required(:start_date).value(:string)
      required(:end_date).value(:string)
    end
  end

  rule(:partitions).validate(:max_thirty_days, :overlap)
  rule(:employee_id, :partitions).validate(:availability, :partitioning)
end
