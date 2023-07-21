# frozen_string_literal: true

class ListEmployeeSerializer < ActiveModel::Serializer
  attributes :name, :position, :hire_date
end
