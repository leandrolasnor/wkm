import React, { useState } from 'react'
import { Container, Row, Button } from "react-bootstrap";
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
  const [showEmployeeForm, setShowEmployeeForm] = useState(false);

  return(
    <OpaqueContainer className="pt-2 pb-2" lg={12} md={12} sm={12} xs={12}>
      <Row>
        <Button variant="outline-success" onClick={() => setShowEmployeeForm(true)}>Hire!</Button>
      </Row>
      <OpaqueRow>
        <Grid />
      </OpaqueRow>
      <FormEmployee title="New" subtitle="Employee" show={showEmployeeForm} handleClose={() => setShowEmployeeForm(false)} />
    </OpaqueContainer>
  )
}

export default Employees