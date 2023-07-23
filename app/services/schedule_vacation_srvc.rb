# frozen_string_literal: true

class ScheduleVacationSrvc < ApplicationService
  param :params

  option :serializer, default: -> { VacationSerializer }
  option :repository, default: -> { Scheduling::Vacation.new(params) }
  Contract = Scheduling::Vacation::Contract.new

  def call
    scheduled = repository.schedule!

    [scheduled, :created, serializer]
  end
end
