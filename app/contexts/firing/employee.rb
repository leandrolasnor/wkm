# frozen_string_literal: true

class Firing::Employee
  extend Dry::Initializer

  param :params

  option :model, default: -> { Employee }
  option :contract, default: -> { Firing::Employee::Fireable::Contract.new }
  option :fireable, default: -> { contract.call(params.to_h) }

  def fire
    raise StandardError.new(fireable.errors.to_h.to_json) if fireable.failure?

    model.destroy(params[:id])
  end
end
