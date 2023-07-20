# frozen_string_literal: true

class VacationSerializer < ActiveModel::Serializer
  attributes :start_date, :end_date, :employee_id
end
