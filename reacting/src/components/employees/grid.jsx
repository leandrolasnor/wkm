import React, { useState } from 'react'
import { useSelector } from "react-redux";
import Paginator from './paginator'
import Employee from '../employee/component'
import FormVacation from "./form_vacation";
import FormPartitioned from "./form_partitioned";
import FormPromotion from "./form_promotion";

const Grid = () => {
  const employees = useSelector(state => state.employees)
  
  const [showVacationForm, setShowVacationForm] = useState(false)
  const [showPartitionedForm, setShowPartitionedForm] = useState(false)
  const [showPromotionForm, setShowPromotionForm] = useState(false)

  const list = employees.list.map((employee, index) => {
    return (
      <Employee
        key={index}
        employee={employee}
        showVacationForm={props => setShowVacationForm(props)}
        showPartitionedForm={props => setShowPartitionedForm(props)}
        showPromotionForm={props => setShowPromotionForm(props)}
      />
    )
  })

  return(
    <React.Fragment>
      {list}
      <Paginator />
      <FormVacation title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
      <FormPartitioned title="Vacation" show={showPartitionedForm} handleClose={() => setShowPartitionedForm(false)}/>
      <FormPromotion subtitle="Promotion" show={showPromotionForm} handleClose={() => setShowPromotionForm(false)}/>
    </React.Fragment>
  )
}

export default Grid