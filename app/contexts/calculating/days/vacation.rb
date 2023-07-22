# frozen_string_literal: true

class Calculating::Days::Vacation
  extend Dry::Initializer

  param :vacation

  option :start_date, default: -> { vacation.start_date.to_date }
  option :end_date, default: -> { vacation.end_date.to_date }

  def days
    @days ||= (end_date - start_date).to_i
  end
end
