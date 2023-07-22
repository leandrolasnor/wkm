# frozen_string_literal: true

class Firing::Employee
  extend Dry::Initializer

  param :params

  option :model, default: -> { Employee }
  option :employee_id, default: -> { params[:employee_id] }
  option :employee, default: -> { model.find(employee_id) }
  option :contract, default: -> { Firing::Employee::Fireable::Contract.new(employee: employee) }
  option :fireable, default: -> { contract.call(params.to_h) }

  def fire
    if fireable.success?
      employee.destroy
      return employee
    end

    raise StandardError.new(fireable.errors.to_h.to_json)
  end
end
