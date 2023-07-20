# frozen_string_literal: true 

require 'rails_helper'

RSpec.describe Vacation do
  it { is_expected.to belong_to(:employee) }
end
