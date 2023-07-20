# frozen_string_literal: true 

require 'rails_helper'

RSpec.describe Employee do
  it { is_expected.to have_many(:vacations).dependent(:destroy) }
end
