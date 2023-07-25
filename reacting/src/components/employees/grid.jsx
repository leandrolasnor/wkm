import React, { useState } from 'react'
import { useDispatch, useSelector } from "react-redux";
import { createVacation, promoteEmployee, partitionedSchedule } from './actions'
import Paginator from './paginator'
import Employee from '../employee/component'
import FormVacation from "./form_vacation";
import FormPartitioned from "./form_partitioned";
import FormPromotion from "./form_promotion";

const Grid = () => {
  const dispatch = useDispatch()
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
      <FormVacation save={props => dispatch(createVacation(props))} title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
      <FormPartitioned save={props => dispatch(partitionedSchedule(props))} title="Vacation" show={showPartitionedForm} handleClose={() => setShowPartitionedForm(false)}/>
      <FormPromotion save={props => dispatch(promoteEmployee(props))} subtitle="Promotion" show={showPromotionForm} handleClose={() => setShowPromotionForm(false)}/>
    </React.Fragment>
  )
}

export default Grid