# frozen_string_literal: true

class Vacation < ApplicationRecord
  acts_as_paranoid

  belongs_to :employee

  delegate :days, to: :calculating_days

  private

  def calculating_days
    @calculating_days ||= Calculating::Days::Vacation.new(self)
  end
end
