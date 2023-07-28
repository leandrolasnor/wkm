# frozen_string_literal: true

class Firing::Employee
  extend Dry::Initializer

  param :params

  option :model, default: -> { Employee }
  option :employee, default: -> { model.find(params[:id]) }
  option :contract, default: -> { Firing::Employee::Fireable::Contract.new(employee: employee) }
  option :fireable, default: -> { contract.call(params.to_h) }

  def fire
    raise StandardError.new(fireable.errors.to_h.to_json) if fireable.failure?

    employee.destroy
  end
end
