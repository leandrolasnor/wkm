# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController do
  before do
    Timecop.freeze('2023-07-01 09:00:00')
    Bullet.enable = false
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
            id: be_a(Integer),
            name: 'Valdez',
            position: 'Analyst',
            hire_date: '2023-07-01',
            enjoyed: 0,
            vacation_days_available: 0,
            working_for: '0 days',
            working: true
          }
        end

        before do
          post(hire_employee_path, params: params, as: :json)
        end

        it "must be able to hire a employee" do
          expect(response).to be_created
          expect(json_body).to match(expected_json_body)
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

        it "must be able to get validation errors" do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end

  describe "PATCH /promotion" do
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
            id: be_a(Integer),
            name: 'Eduardo',
            position: 'Chair Man',
            hire_date: '2023-07-01',
            vacation_days_available: 0,
            enjoyed: 0,
            working_for: '0 days',
            working: true
          }
        end

        before do
          patch(promotion_employee_path, params: params, as: :json)
        end

        it "must be able to advanced a employee to Chair Man" do
          expect(response).to be_successful
          expect(json_body).to match(expected_json_body)
        end
      end

      context 'on not_found' do
        let(:params) { { id: 0, position: 'Chair Man' } }

        let(:expected_json_body) do
          {
            employee: [I18n.t('dry_validation.errors.valid_identifier')]
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
        let(:params) { { employee: { id: employee.id } } }
        let(:paranoia_employee) { Employee.only_deleted.find(employee.id) }
        let(:employee) { create(:employee, :analyst, name: 'Arthur') }
        let(:expected_json_body) do
          {
            id: be_a(Integer),
            name: 'Arthur',
            position: 'Analyst',
            hire_date: '2023-07-01',
            vacation_days_available: 0,
            working_for: '0 days',
            enjoyed: 0,
            working: true
          }
        end

        before do
          delete(fire_employee_path, params: params, as: :json)
        end

        it 'must be able to fire the employee with soft delete' do
          expect(response).to be_successful
          expect(json_body).to match(expected_json_body)
          expect(paranoia_employee).not_to be_nil
        end
      end

      context 'on not_found' do
        let(:params) { { employee: { id: 0 } } }
        let(:expected_json_body) do
          {
            employee: [I18n.t('dry_validation.errors.valid_identifier')]
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

      context 'when employee is enjoying your vacation' do
        let(:params) { { id: employee.id } }
        let(:employee) do
          e = create(:employee)
          create(
            :vacation,
            start_date: '2023-06-07',
            end_date: '2023-07-07',
            employee_id: e.id
          )
          e
        end
        let(:expected_json_body) do
          {
            fireable: [I18n.t('dry_validation.errors.not_fireable')]
          }
        end

        before do
          delete(fire_employee_path, params: params, as: :json)
        end

        it 'must not be able to get a not fireable message' do
          expect(response).to be_unprocessable
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end

  describe 'GET /list' do
    let(:employees) { create_list(:employee, 15) }
    let(:keys) do
      [
        :id,
        :name,
        :position,
        :enjoyed,
        :vacation_days_available,
        :working_for,
        :hire_date,
        :working
      ]
    end

    before do
      employees
    end

    context 'on page 1' do
      let(:params) { { page: 1, per_page: 10 } }

      before do
        get(list_employees_path, params: params, as: :json)
      end

      it 'must be able to get teen employees' do
        expect(response).to be_successful
        expect(json_body).to be_a(Array)
        expect(json_body.size).to be(10)
        expect(json_body.first.keys).to match_array(keys)
      end
    end

    context 'on page 2' do
      let(:params) { { page: 2, per_page: 10 } }

      before do
        get(list_employees_path, params: params, as: :json)
      end

      it 'must be able to get others five employees' do
        expect(response).to be_successful
        expect(json_body).to be_a(Array)
        expect(json_body.size).to be(5)
        expect(json_body.first.keys).to match_array(keys)
      end
    end
  end
end
