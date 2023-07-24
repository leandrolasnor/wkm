# frozen_string_literal: true

class ListEmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :hire_date
end
