# frozen_string_literal: true

class Scheduling::Partitioned::Vacation
  extend Dry::Initializer

  param :params

  option :partitions, default: -> { params[:partitions] { _1.merge(employee_id: params[:employee_id]) } }
  option :model, default: -> { Vacation }
  option :contract, default: -> { Employing::Laws::Partitioned::Vacation::Law.new.call(params.to_h) }

  def schedule
    return model.create(partitions) if contract.success?

    raise StandardError.new(contract.errors.to_h.to_json)
  end
end
