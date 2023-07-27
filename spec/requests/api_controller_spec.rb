# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiController do
  describe 'GET /health' do
    before do
      get('/health')
    end

    it 'must be able to get a oks message' do
      expect(response).to be_successful
    end
  end

  describe 'GET /not_found' do
    before do
      get("/not_found")
    end

    it 'must be able to get a not found response status' do
      expect(response).to be_not_found
    end
  end
end
