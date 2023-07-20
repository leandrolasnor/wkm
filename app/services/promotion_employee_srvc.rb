# frozen_string_literal: true

class PromotionEmployeeSrvc < ApplicationService
  extend Dry::Initializer

  param :employee

  option :repository, default: -> { Promotion::Employee.new(employee) }
  option :serializer, default: -> { EmployeeSerializer }
  Schema = Promotion::Employee::Schema.new

  def call
    advanced = repository.advance

    [advanced, :ok, serializer]
  end
end
