# frozen_string_literal: true 

require 'rails_helper'

RSpec.describe Employee do
  it { is_expected.to have_many(:vacations).dependent(:destroy) }
  it { is_expected.to delegate_method(:vacation_days_available).to(:calculating_days) }
  it { is_expected.to delegate_method(:enjoyed).to(:calculating_days) }
  it { is_expected.to respond_to(:enjoyed) }
  it { is_expected.to respond_to(:vacation_days_available) }
end
