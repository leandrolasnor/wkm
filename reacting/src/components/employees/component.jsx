import "bootstrap/dist/css/bootstrap.min.css";
import React, { useState, useEffect } from 'react'
import { useDispatch, useSelector } from "react-redux";
import { Container, Row, Col, Button } from "react-bootstrap";
import { getEmployees, createEmployee, createVacation } from './actions'
import Employee from '../employee/component'
import FormEmployee from "./form_employee";
import FormVacation from "./form_vacation";

const Employees = () => {
  const dispatch = useDispatch()
  const employees = useSelector(state => state.employees)

  const {list, complete} = employees;

  const [page, setPage] = useState(0)
  const [showEmployeeForm, setShowEmployeeForm] = useState(false);	
  const [showVacationForm, setShowVacationForm] = useState(false);	

  useEffect(() => {setPage(1)}, [])
  useEffect(() => {if(!complete) dispatch(getEmployees(page));}, [page])

  const grid = list.map( (employee, index) => {
    return (<Employee key={index} employee={employee} showVacationForm={props => setShowVacationForm(props)} />)
  })

  return(
    <Container style={{backgroundColor: 'rgba(0, 0, 0, 0.08)'}} className="mt-5 mb-5" lg={12} md={12} sm={12} xs={12}>
      <Row>
        <h1>Company</h1>
      </Row>
      <Row>
        <Col lg={1}>
          <h6>Staff</h6>
        </Col>
        <Col className="mb-5" lg={12}>
          <Button variant="outline-secondary"onClick={() => setShowEmployeeForm(true)}>Increase</Button>
        </Col>
      </Row>
      <Row style={{backgroundColor: 'rgba(0, 0, 0, 0.07)'}}>
        <Col lg={12} className="mb-5">
          <Row>
            {grid}
          </Row>
        </Col>
      </Row>
      <Row>
        { complete ? null : <Button onClick={() => setPage(page+1)}>More</Button> }
      </Row>
      <FormEmployee save={props => dispatch(createEmployee(props))} title="New" subtitle="Employee" show={showEmployeeForm} handleClose={() => setShowEmployeeForm(false)}/>
      <FormVacation save={props => dispatch(createVacation(props))} title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
    </Container>
  )
}

export default Employees