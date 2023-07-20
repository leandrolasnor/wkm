# frozen_string_literal: true

class Firing::Employee
  extend Dry::Initializer

  param :params

  option :id, default: -> { params[:id] }
  option :model, default: -> { Employee }

  def fire
    employee = model.find(id)
    employee.destroy
    employee
  end
end
