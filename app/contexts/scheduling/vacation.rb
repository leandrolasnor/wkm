# frozen_string_literal: true 

class Scheduling::Vacation
  extend Dry::Initializer

  param :params

  option :model, default: -> { Vacation }

  def schedule
    model.create(params)
  end
end
