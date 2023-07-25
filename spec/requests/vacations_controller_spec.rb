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
          employee: [I18n.t('dry_validation.errors.valid_identifier')]
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

  describe "POST /partitioned_schedule" do
    let(:params) do
      {
        partitions: [
          {
            start_date: '2023-04-02',
            end_date: '2023-04-16'
          },
          {
            start_date: '2023-05-20',
            end_date: '2023-05-25'
          },
          {
            start_date: '2023-12-26',
            end_date: '2023-12-31'
          }
        ],
        employee_id: employee.id
      }
    end

    context 'when a vacations was scheduled' do
      let(:expected_json_body) do
        [
          { employee_id: be_a(Integer), start_date: '2023-04-02', end_date: '2023-04-16' },
          { employee_id: be_a(Integer), start_date: '2023-05-20', end_date: '2023-05-25' },
          { employee_id: be_a(Integer), start_date: '2023-12-26', end_date: '2023-12-31' }
        ]
      end

      before do
        post(partitioned_schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to schedule vacation' do
        expect(response).to be_created
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when params is missing' do
      let(:params) do
        {
          partitions: [
            {
              start_date: '2023-04-02',
              end_date: '2023-04-16'
            },
            {},
            {}
          ],
          employee_id: employee.id
        }
      end

      let(:expected_json_body) do
        {
          partitions: {
            '1': { start_date: ['is missing'], end_date: ['is missing'] },
            '2': { start_date: ['is missing'], end_date: ['is missing'] }
          }
        }
      end

      before do
        post(partitioned_schedule_vacation_path, params: params, as: :json)
      end

      it 'must to happen something' do
        expect(response).to be_unprocessable
        expect(json_body).to eq(expected_json_body)
      end
    end

    context 'when the employee is not found' do
      let(:expected_json_body) do
        {
          employee_id: [
            I18n.t('dry_validation.errors.valid_identifier'),
            I18n.t('dry_validation.errors.valid_identifier')
          ]
        }
      end

      before do
        post(partitioned_schedule_vacation_path, params: params.merge(employee_id: 0), as: :json)
      end

      it 'must not be able to schedule vacations' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when the dates are invalid dates' do
      let(:params) do
        {
          partitions: [
            {
              start_date: '2023-04-02',
              end_date: 'invalid date'
            },
            {
              start_date: '2023-05-20',
              end_date: '2023-05-24'
            },
            {
              start_date: '2023-12-26',
              end_date: '2023-12-31'
            }
          ],
          employee_id: employee.id
        }
      end

      let(:expected_json_body) do
        {
          partitions: [I18n.t('dry_validation.errors.date_format_invalid')]
        }
      end

      before do
        post(partitioned_schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when end date is before than start date' do
      let(:params) do
        {
          partitions: [
            {
              start_date: '2023-04-02',
              end_date: '2023-04-16'
            },
            {
              start_date: '2023-05-24',
              end_date: '2023-05-20'
            },
            {
              start_date: '2023-12-26',
              end_date: '2023-12-31'
            }
          ],
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
        post(partitioned_schedule_vacation_path, params: params, as: :json)
      end

      it 'must be able to get a schedule item' do
        expect(response).to be_unprocessable
        expect(json_body).to match(expected_json_body)
      end
    end

    context 'when there is a prevent' do
      context 'on law' do
        context 'on availability and max_thirty_days' do
          let(:params) do
            {
              partitions: [
                {
                  start_date: '2023-04-02',
                  end_date: '2023-04-16'
                },
                {
                  start_date: '2023-05-02',
                  end_date: '2023-05-16'
                },
                {
                  start_date: '2024-01-02',
                  end_date: '2024-01-16'
                }
              ],
              employee_id: employee.id
            }
          end

          let(:expected_json_body) do
            {
              availability: [I18n.t('dry_validation.errors.availability')],
              max_thirty_days: [I18n.t('dry_validation.errors.period_greater_than_thrity')]
            }
          end

          before do
            Timecop.freeze('2022-10-01')
            post(partitioned_schedule_vacation_path, params: params, as: :json)
          end

          after do
            Timecop.return
          end

          it 'must be able to get a schedule item' do
            expect(response).to be_unprocessable
            expect(json_body).to eq(expected_json_body)
          end
        end

        context 'on availability and overlap' do
          let(:vacation) do
            create(
              :vacation,
              start_date: '2023-05-23',
              end_date: '2023-05-31',
              employee_id: employee.id
            )
          end

          let(:expected_json_body) do
            {
              overlap: [I18n.t('dry_validation.errors.overlap')],
              availability: [I18n.t('dry_validation.errors.availability')]
            }
          end

          before do
            vacation
            post(partitioned_schedule_vacation_path, params: params, as: :json)
          end

          it 'must be able to get a availability and overlap errors' do
            expect(response).to be_unprocessable
            expect(json_body).to eq(expected_json_body)
          end
        end

        context 'on overlap' do
          let(:params) do
            {
              partitions: [
                {
                  start_date: '2023-04-02',
                  end_date: '2023-04-16'
                },
                {
                  start_date: '2023-05-20',
                  end_date: '2023-05-25'
                },
                {
                  start_date: '2023-05-22',
                  end_date: '2023-05-27'
                }
              ],
              employee_id: employee.id
            }
          end

          let(:expected_json_body) do
            {
              overlap: [I18n.t('dry_validation.errors.overlap')]
            }
          end

          before do
            post(partitioned_schedule_vacation_path, params: params, as: :json)
          end

          it 'must be able to get a overlap error' do
            expect(response).to be_unprocessable
            expect(json_body).to eq(expected_json_body)
          end
        end

        context 'on partitioning' do
          let(:params) do
            {
              partitions: [
                {
                  start_date: '2023-04-05',
                  end_date: '2023-04-16'
                },
                {
                  start_date: '2023-05-23',
                  end_date: '2023-05-25'
                },
                {
                  start_date: '2023-12-28',
                  end_date: '2023-12-31'
                }
              ],
              employee_id: employee.id
            }
          end

          let(:expected_json_body) do
            {
              partitioning: [
                I18n.t('dry_validation.errors.min_fourteen_request_days'),
                I18n.t('dry_validation.errors.min_five_request_days'),
                I18n.t('dry_validation.errors.min_five_request_days')
              ]
            }
          end

          before do
            post(partitioned_schedule_vacation_path, params: params, as: :json)
          end

          it 'must be able to get a partitioning error' do
            expect(response).to be_unprocessable
            expect(json_body).to eq(expected_json_body)
          end
        end
      end
    end
  end
end
