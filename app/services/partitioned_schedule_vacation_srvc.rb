# frozen_string_literal: true

class PartitionedScheduleVacationSrvc < ApplicationService
  param :params

  option :serializer, default: -> { VacationSerializer }
  option :repository, default: -> { Scheduling::Partitioned::Vacation.new(params) }
  Contract = Scheduling::Partitioned::Vacation::Contract.new

  def call
    scheduled = repository.schedule

    [scheduled, :created, serializer]
  rescue StandardError => error
    [error.message, :unprocessable_entity, nil]
  end
end
