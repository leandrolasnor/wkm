# frozen_string_literal: true

class Hiring::Employee
  extend Dry::Initializer

  param :params

  option :model, default: -> { Employee }

  def hire
    model.create(hire_date: Time.zone.today, **params)
  end
end
