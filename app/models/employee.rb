# frozen_string_literal: true

class Employee < ApplicationRecord
  acts_as_paranoid

  has_many :vacations, dependent: :destroy
end
