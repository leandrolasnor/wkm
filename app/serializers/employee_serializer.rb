# frozen_string_literal: true

class EmployeeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :position, :hire_date
end
