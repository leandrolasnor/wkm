# frozen_string_literal: true

class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from StandardError, with: :error

  def not_found
    head :not_found
  end

  def health
    render body: 'I am here!', status: :ok
  end

  private

  def error
    head :internal_server_error
  end

  def resolve(content:, status:, serializer: nil)
    render json: content, status: status, each_serializer: serializer
  end
end
