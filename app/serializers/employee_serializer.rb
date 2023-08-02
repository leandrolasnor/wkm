# frozen_string_literal: true

class EmployeeSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :position,
    :hire_date,
    :vacation_days_available,
    :enjoyed,
    :working_for,
    :working
  )

  def working
    !object.vacations.exists?(['? >= start_date and end_date > ?', Time.zone.today, Time.zone.today])
  end

  def working_for
    worked_days = (Time.zone.today - object.hire_date).to_i
    worked_years = worked_days.divmod(365).first
    return "#{worked_years} years" if worked_years.positive?

    worked_months = worked_days.divmod(30).first
    return "#{worked_months} months" if worked_months.positive?

    "#{worked_days} days"
  end
end
