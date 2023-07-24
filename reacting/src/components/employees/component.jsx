import React, { useState, useEffect } from 'react'
import { useDispatch, useSelector } from "react-redux";
import Employee from '../employee/component'
import { Home, Header, Subheader, Grid, Button, IncreaseButton } from '../commons/components'
import { getEmployees, createEmployee, createVacation } from './actions'
import FormEmployee from "./form_employee";
import FormVacation from "./form_vacation";
import "bootstrap/dist/css/bootstrap.min.css";

const Employees = () => {
  const dispatch = useDispatch()
  const employees = useSelector(state => state.employees)

  const {list, complete} = employees;

  const [page, setPage] = useState(0)
  const [showEmployeeForm, setShowEmployeeForm] = useState(false);	
  const [showVacationForm, setShowVacationForm] = useState(false);	

  useEffect(() => {setPage(1)}, [])
  useEffect(() => {fetch(complete)}, [page])

  const fetch = complete => {
    if(complete) return;
    dispatch(getEmployees(page))
  }

  const grid = list.map( (employee, index) => {
    return (<Employee key={index} employee={employee} showVacationForm={props => setShowVacationForm(props)} />)
  })

  return(
    <Home>
      <Header>
        <h1>Company</h1>
        <Subheader>Staff</Subheader>
        <IncreaseButton onClick={() => setShowEmployeeForm(true)}>Increase</IncreaseButton>
      </Header>
      <Grid>
        {grid}
      </Grid>
      { complete ? null : <Button onClick={() => setPage(page+1)}>More</Button> }
      <FormEmployee save={props => dispatch(createEmployee(props))} title="New" subtitle="Employee" show={showEmployeeForm} handleClose={() => setShowEmployeeForm(false)}/>
      <FormVacation save={props => dispatch(createVacation(props))} title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
    </Home>
  )
}

export default Employees