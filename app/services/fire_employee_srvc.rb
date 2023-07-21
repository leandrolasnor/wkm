# frozen_string_literal: true

class FireEmployeeSrvc < ApplicationService
  param :params

  option :serializer, default: -> { EmployeeSerializer }
  option :repository, default: -> { Firing::Employee.new(params) }
  Schema = Firing::Employee::Schema.new

  def call
    fired = repository.fire

    [fired, :ok, serializer]
  end
end
