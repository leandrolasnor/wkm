# frozen_string_literal: true

class Promotion::Employee
  extend Dry::Initializer

  param :params

  option :employee_id, default: -> { params[:employee_id] }
  option :position, default: -> { params[:position] }
  option :model, default: -> { Employee }

  def advance
    model.update(employee_id, position: position)
  end
end
