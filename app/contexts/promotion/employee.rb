# frozen_string_literal: true

class Promotion::Employee
  extend Dry::Initializer

  param :params

  option :id, default: -> { params[:id] }
  option :position, default: -> { params[:position] }
  option :model, default: -> { Employee }

  def advance
    model.update(id, position: position)
  end
end
