# frozen_string_literal: true

class Employing::Laws::Vacation::Law < Employing::Laws::Vacation::Macros
  params do
    required(:employee_id).value(:integer)
    required(:start_date).value(:string)
    required(:end_date).value(:string)
  end

  rule(:start_date, :end_date, :employee_id).validate(:availability)
  rule(:start_date, :end_date, :employee_id).validate(:min_teen_days)
  rule(:start_date, :end_date, :employee_id).validate(:overlap)
end
