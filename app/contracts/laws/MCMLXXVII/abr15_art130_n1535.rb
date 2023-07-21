# frozen_string_literal: true

class Laws::MCMLXXVII::Abr15Art130N1535 < Dry::Validation::Contract
  params do
    required(:employee_id).value(:integer)
    required(:start_date).value(:string)
    required(:end_date).value(:string)
  end

  rule(:start_date, :end_date, :employee_id) do
    employee = Employee.find(values[:employee_id])
    worked_days = (values[:start_date].to_date - employee.hire_date).to_i
    key(:employee_id).failure(I18n.t(:thirty_days_each_period_twelve_months)) if worked_days < 365
  end
end
