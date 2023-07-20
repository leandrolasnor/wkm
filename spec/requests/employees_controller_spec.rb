# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController do
  describe "POST /hire" do
    before do
      Timecop.freeze('2023-07-01 09:00:00')
    end

    after do
      Timecop.return
    end

    context "when hire a employee" do
      context "on success" do
        let(:params) { { name: 'Valdez', position: 'Analyst' } }
        let(:expected_json_body) do
          {
            name: 'Valdez',
            position: 'Analyst',
            hire_date: '2023-07-01'
          }
        end

        before do
          post(employees_hire_path, params: params, as: :json)
        end

        it "must be able to hire a employee" do
          expect(response).to be_created
          expect(json_body).to eq(expected_json_body)
        end
      end
    end

    context "when promotion a employee" do
      context "on success" do
        let(:params) { { id: employee.id, position: 'Chair Man' } }
        let(:employee) do
          create(
            :employee,
            :analyst,
            name: 'Eduardo',
            position: 'Director'
          )
        end
        let(:expected_json_body) do
          {
            name: 'Eduardo',
            position: 'Chair Man',
            hire_date: '2023-07-01'
          }
        end

        before do
          patch(employees_promotion_path, params: params, as: :json)
        end

        it "must be able to advanced a employee to Chair Man" do
          expect(response).to be_successful
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end
end
