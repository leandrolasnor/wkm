import React, { useState } from 'react'
import { useDispatch, useSelector } from "react-redux";
import { createVacation } from './actions'
import Paginator from './paginator'
import Employee from '../employee/component'
import FormVacation from "./form_vacation";

const Grid = () => {
  const dispatch = useDispatch()
  const employees = useSelector(state => state.employees)
  
  const [showVacationForm, setShowVacationForm] = useState(false)

  const list = employees.list.map((employee, index) => {
    return (<Employee key={index} employee={employee} showVacationForm={props => setShowVacationForm(props)} />)
  })

  return(
    <React.Fragment>
      {list}
      <Paginator />
      <FormVacation save={props => dispatch(createVacation(props))} title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
    </React.Fragment>
  )
}

export default Grid