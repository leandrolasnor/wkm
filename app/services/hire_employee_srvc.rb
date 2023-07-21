# frozen_string_literal: true

class HireEmployeeSrvc < ApplicationService
  param :employee
  option :serializer, default: -> { EmployeeSerializer }
  option :repository, default: -> { Hiring::Employee.new(employee) }
  Contract = Hiring::Employee::Contract.new

  def call
    hired = repository.hire

    [hired, :created, serializer]
  end
end
