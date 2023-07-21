# frozen_string_literal: true

class Scheduling::Vacation
  extend Dry::Initializer

  param :params

  option :model, default: -> { Vacation }
  option :employment_laws, default: -> {
    [
      Laws::MCMLXXVII::Abr15Art130N1535.new.call(params.to_h)
    ]
  }
  option :preventions, default: -> { employment_laws.select(&:failure?) }

  def schedule
    return model.create(params) unless preventions.any?

    raise StandardError.new(preventions.flatten.map { _1.errors.to_h }.to_json)
  end
end
