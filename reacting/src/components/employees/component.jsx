import React, { useState } from 'react'
import { useDispatch } from "react-redux";
import { Container, Row, Col, Button } from "react-bootstrap";
import { createEmployee } from './actions'
import FormEmployee from "./form_employee";
import Grid from './grid'
import styled from 'styled-components'

const OpaqueContainer = styled(Container)`
  background-color: rgba(0, 0, 0, 0.08)
`
const OpaqueRow = styled(Row)`
  background-color: rgba(0, 0, 0, 0.07)
`

const Employees = () => {
  const dispatch = useDispatch()
  const [showEmployeeForm, setShowEmployeeForm] = useState(false);

  return(
    <OpaqueContainer className="pt-2 pb-2" lg={12} md={12} sm={12} xs={12}>
      <Row><h1>Break::Break</h1></Row>
      <Row>
        <Col className='pb-3'>
          <Button variant="outline-success"onClick={() => setShowEmployeeForm(true)}>Hire!</Button>
        </Col>
      </Row>
      <OpaqueRow><Grid /></OpaqueRow>
      <FormEmployee
        save={props => dispatch(createEmployee(props))}
        title="New"
        subtitle="Employee"
        show={showEmployeeForm}
        handleClose={() => setShowEmployeeForm(false)}
      />
    </OpaqueContainer>
  )
}

export default Employees