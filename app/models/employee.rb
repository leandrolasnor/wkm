# frozen_string_literal: true

class Employee < ApplicationRecord
  acts_as_paranoid

  has_many :vacations, dependent: :destroy

  delegate :vacation_days_available, to: :calculating_days
  delegate :enjoyed, to: :calculating_days

  private

  def calculating_days
    @calculating_days ||= Calculating::Days::Employee.new(self)
  end
end
