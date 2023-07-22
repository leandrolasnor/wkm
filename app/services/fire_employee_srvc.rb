# frozen_string_literal: true

class FireEmployeeSrvc < ApplicationService
  param :params

  option :serializer, default: -> { EmployeeSerializer }
  option :repository, default: -> { Firing::Employee.new(params) }
  Contract = Firing::Employee::Contract.new

  def call
    fired = repository.fire

    [fired, :ok, serializer]
  rescue StandardError => error
    [error.message, :unprocessable_entity, nil]
  end
end
