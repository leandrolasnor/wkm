# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VacationsController do
  let(:employee) { create(:employee, hire_date: '2022-04-01') }

  before do
    Timecop.freeze('2023-07-01 09:00:00')
  end

  after do
    Timecop.return
  end

  describe "POST /schedule" do
    context 'when a vacation is scheduled' do
      let(:params) do
        {
          start_date: '2023-11-02',
          end_date: '2023-12-02',
          employee_id: employee.id
        }
      end

      let(:expected_json_body) do
        {
          employee_id: be_a(Integer),
          start_date: '2023-11-02',
          end_date: '2023-12-02'
        }
      end

      before do
        post(schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_created
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when the employee is not found' do
      let(:params) do
        {
          start_date: '2023-11-02',
          end_date: '2023-12-02',
          employee_id: 0
        }
      end

      let(:expected_json_body) do
        {
          employee_id: ["must be a valid registration identifier"]
        }
      end

      before do
        post(schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when the dates are invalid dates' do
      let(:params) do
        {
          start_date: 'invalid date',
          end_date: 'invalid date',
          employee_id: employee.id
        }
      end

      let(:expected_json_body) do
        {
          start_date: ["must be filled with Y-m-d date format"],
          end_date: ["must be filled with Y-m-d date format"]
        }
      end

      before do
        post(schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when end date is lower than start date' do
      let(:params) do
        {
          start_date: '2023-12-02',
          end_date: '2023-11-02',
          employee_id: employee.id
        }
      end

      let(:expected_json_body) do
        {
          start_date: ["must be before end date"],
          end_date: ["must be after start date"]
        }
      end

      before do
        post(schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when there is a prevent' do
      context 'on MCMLXXVII::Abr15Art130N1535' do
        let(:params) do
          {
            start_date: '2022-11-02',
            end_date: '2022-12-02',
            employee_id: employee.id
          }
        end

        let(:expected_json_body) do
          [{ employee_id: [I18n.t(:thirty_days_each_period_twelve_months)] }]
        end

        before do
          post(schedule_vacation_path, params: params, as: :json)
        end

        it 'must be able to get a schedule item' do
          expect(response).to be_unprocessable
          expect(json_body).to eq(expected_json_body)
        end
      end
    end
  end
end
