# frozen_string_literal: true

class Calculating::Days::Employee
  extend Dry::Initializer

  param :employee

  option :hire_date, default: -> { employee.hire_date.to_date }
  option :today, default: -> { Time.zone.now.to_date }
  option :worked_days, default: -> { (today - hire_date).to_i }
  option :worked_years, default: -> { worked_days.divmod(365).first }
  option :total_vacation, default: -> { worked_years * 30 }

  def vacation_days_available
    @vacation_days_available ||= total_vacation - enjoyed
  end

  private

  def enjoyed
    @enjoyed ||= employee.vacations.sum do
      end_date = _1.end_date.to_date
      start_date = _1.start_date.to_date

      (end_date - start_date).to_i
    end
  end
end
