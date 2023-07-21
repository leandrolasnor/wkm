# frozen_string_literal: true

class PromotionEmployeeSrvc < ApplicationService
  param :params

  option :repository, default: -> { Promotion::Employee.new(params) }
  option :serializer, default: -> { EmployeeSerializer }
  Contract = Promotion::Employee::Contract.new

  def call
    advanced = repository.advance

    [advanced, :ok, serializer]
  end
end
