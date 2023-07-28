# frozen_string_literal: true

class EmployeesController < ApiController
  def list
    resolve(**ListEmployeeSrvc.call(list_params))
  end

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
    params.fetch(:employee, {})
  end

  def list_params
    params.permit(:page, :per_page)
  end

  def hire_params
    params_employee.permit(:name, :position)
  end

  def promotion_params
    params_employee.permit(:id, :position)
  end

  def fire_params
    params_employee.permit(:id)
  end
end
