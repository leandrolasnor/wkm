# frozen_string_literal: true

class ListEmployeeSrvc < ApplicationService
  param :params

  option :serializer, default: -> { EmployeeSerializer }
  option :repository, default: -> { Listing::Employees.new(params) }
  Contract = Listing::Employee::Contract.new

  def call
    list = repository.list

    [list, :ok, serializer]
  end
end
