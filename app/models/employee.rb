# frozen_string_literal: true

class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy
end
