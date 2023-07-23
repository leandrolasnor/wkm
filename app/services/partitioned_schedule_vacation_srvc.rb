# frozen_string_literal: true

class PartitionedScheduleVacationSrvc < ApplicationService
  param :params

  option :serializer, default: -> { VacationSerializer }
  option :repository, default: -> { Scheduling::Partitioned::Vacation.new(params) }
  Contract = Scheduling::Vacation::Partitioned::Contract.new

  def call
    scheduled = repository.schedule!

    [scheduled, :created, serializer]
  end
end
