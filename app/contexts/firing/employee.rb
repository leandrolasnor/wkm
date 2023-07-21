# frozen_string_literal: true

class Firing::Employee
  extend Dry::Initializer

  param :params

  option :employee_id, default: -> { params[:employee_id] }
  option :model, default: -> { Employee }

  def fire
    employee = model.find(employee_id)
    employee.destroy
    employee
  end
end
