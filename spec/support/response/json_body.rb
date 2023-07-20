# frozen_string_literal: true

module JsonBody
  def json_body
    JSON.parse(response.body, symbolize_names: true) if response.body.presence
  end
end
