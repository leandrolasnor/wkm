# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController do
  before do
    Timecop.freeze('2023-07-01 09:00:00')
  end

  after do
    Timecop.return
  end

  describe "POST /hire" do
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
          post(hire_employee_path, params: params, as: :json)
        end

        it "must be able to hire a employee" do
          expect(response).to be_created
          expect(json_body).to eq(expected_json_body)
        end
      end

      context 'on validation error' do
        let(:expected_json_body) do
          {
            name: ["is missing"],
            position: ["must be a string"]
          }
        end

        before do
          post(hire_employee_path, params: { position: 7 }, as: :json)
        end

        it "must be able to hire a employee" do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end

  describe "PATCH /promotion" do
    context "when promotion a employee" do
      context "on success" do
        let(:params) { { employee_id: employee.id, position: 'Chair Man' } }
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
          patch(promotion_employee_path, params: params, as: :json)
        end

        it "must be able to advanced a employee to Chair Man" do
          expect(response).to be_successful
          expect(json_body).to eq(expected_json_body)
        end
      end

      context 'on not_found' do
        let(:params) { { employee_id: 0, position: 'Chair Man' } }

        let(:expected_json_body) do
          {
            employee_id: ["must be a valid registration identifier"]
          }
        end

        before do
          patch(promotion_employee_path, params: params, as: :json)
        end

        it "must be able to get http status as not_found" do
          expect(response).to be_unprocessable
          expect(json_body).to eql(expected_json_body)
        end
      end
    end
  end

  describe "DELETE /fire" do
    context 'when fire a employee' do
      context 'on success' do
        let(:params) { { employee_id: employee.id } }
        let(:paranoia_employee) { Employee.only_deleted.find(employee.id) }
        let(:employee) { create(:employee, :analyst, name: 'Arthur') }
        let(:expected_json_body) do
          {
            name: 'Arthur',
            position: 'Analyst',
            hire_date: '2023-07-01'
          }
        end

        before do
          delete(fire_employee_path, params: params, as: :json)
        end

        it 'must be able to soft delete the employee' do
          expect(response).to be_successful
          expect(json_body).to eq(expected_json_body)
          expect(paranoia_employee).not_to be_nil
        end
      end

      context 'on not_found' do
        let(:params) { { employee_id: 0, position: 'Chair Man' } }
        let(:expected_json_body) do
          {
            employee_id: ["must be a valid registration identifier"]
          }
        end

        before do
          delete(fire_employee_path, params: params)
        end

        it "must be able to get http status as not_found" do
          expect(response).to be_unprocessable
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end
end
