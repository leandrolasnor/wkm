# frozen_string_literal: true

class Listing::Employees
  extend Dry::Initializer

  param :params

  option :page, default: -> { params[:page] }
  option :per_page, default: -> { params[:per_page] }

  option :model, default: -> { Employee }

  def list
    model.page(page).per(per_page)
  end
end
