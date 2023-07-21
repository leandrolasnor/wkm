# frozen_string_literal: true

class VacationsController < ApiController
  def schedule
    resolve(**ScheduleVacationSrvc.call(schedule_params))
  end

  private

  def vacation_params
    params.fetch(:vacation, {})
  end

  def schedule_params
    vacation_params.permit(:start_date, :end_date, :employee_id)
  end
end
