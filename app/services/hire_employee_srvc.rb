# frozen_string_literal: true

class HireEmployeeSrvc < ApplicationService
  extend Dry::Initializer

  param :employee
  option :serializer, default: -> { EmployeeSerializer }
  option :repository, default: -> { Hiring::Employee.new(employee) }
  Schema = Hiring::Employee::Schema.new

  def call
    hired = repository.hire

    [hired, :created, serializer]
  end
end
