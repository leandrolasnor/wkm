# frozen_string_literal: true

class EmployeesController < ApiController
  def hire
    resolve(**HireEmployeeSrvc.call(hire_params))
  end

  def promotion
    resolve(**PromotionEmployeeSrvc.call(promotion_params))
  end

  def fire
    resolve(**FireEmployeeSrvc.call(fire_params))
  end

  private

  def params_employee
    params.fetch(:employee)
  end

  def hire_params
    params_employee.permit(:name, :position)
  end

  def promotion_params
    params.permit(:employee_id, :position)
  end

  def fire_params
    params.permit(:employee_id)
  end
end
