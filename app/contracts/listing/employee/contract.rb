# frozen_string_literal: true

class Listing::Employee::Contract < Dry::Validation::Contract
  params do
    required(:page).filled(:integer)
    required(:per_page).filled(:integer)
  end
end
