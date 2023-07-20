# frozen_string_literal: true

class VacationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_date, :end_date
end
