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
      <Row><h1>Company</h1></Row>
      <Row>
        <Col lg={1}><h6>Staff</h6></Col>
        <Col className="mb-5" lg={12}>
          <Button variant="outline-secondary"onClick={() => setShowEmployeeForm(true)}>Increase</Button>
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