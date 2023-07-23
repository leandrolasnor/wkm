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
          employee_id: [I18n.t('dry_validation.errors.valid_identifier')]
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
          start_date: [I18n.t('dry_validation.errors.date_format_invalid')],
          end_date: [I18n.t('dry_validation.errors.date_format_invalid')]
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
          start_date: [I18n.t('dry_validation.errors.before_end_date')],
          end_date: [I18n.t('dry_validation.errors.after_start_date')]
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
      context 'on law' do
        context 'on availability and min_teen_days' do
          let(:params) do
            {
              start_date: '2022-11-02',
              end_date: '2022-11-10',
              employee_id: employee.id
            }
          end

          let(:expected_json_body) do
            {
              availability: [I18n.t('dry_validation.errors.availability')],
              min_teen_days: [I18n.t('dry_validation.errors.min_teen_days')]
            }
          end 

          before do
            Timecop.freeze('2022-10-01')
            post(schedule_vacation_path, params: params, as: :json)
          end

          after do
            Timecop.return
          end

          it 'must be able to get a schedule item' do
            expect(response).to be_unprocessable
            expect(json_body).to eq(expected_json_body)
          end
        end

        context 'on overlap' do
          let(:vacation) do
            create(
              :vacation,
              start_date: '2022-11-02',
              end_date: '2022-11-22',
              employee_id: employee.id
            )
          end

          let(:params) do
            {
              start_date: '2022-11-20',
              end_date: '2022-11-30',
              employee_id: employee.id
            }
          end

          let(:expected_json_body) do
            {
              overlap: [I18n.t('dry_validation.errors.overlap')]
            }
          end

          before do
            vacation
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
end
