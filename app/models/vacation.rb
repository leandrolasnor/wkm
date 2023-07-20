# frozen_string_literal: true

class Vacation < ApplicationRecord
  acts_as_paranoid

  belongs_to :employee
end
