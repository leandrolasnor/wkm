# frozen_string_literal: true

class Scheduling::Vacation
  extend Dry::Initializer

  param :params

  option :model, default: -> { Vacation }
  option :contract, default: -> { Employing::Laws::Vacation::Law.new.call(params.to_h) }

  def schedule!
    return model.create(params) if contract.success?

    raise StandardError.new(contract.errors.to_h.to_json)
  end
end
