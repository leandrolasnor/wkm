# frozen_string_literal: true

class EmployeeSerializer < ActiveModel::Serializer
  attributes :name, :position, :hire_date
end
