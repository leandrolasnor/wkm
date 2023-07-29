import React, { useState } from 'react'
import { Container, Row, Button } from "react-bootstrap";
import FormEmployee from "./form_employee";
import Grid from './grid'

const Employees = () => {
  const [showEmployeeForm, setShowEmployeeForm] = useState(false);

  return(
    <Container className="pt-2 pb-2" lg={12} md={12} sm={12} xs={12}>
      <Row>
        <Button variant="outline-success" onClick={() => setShowEmployeeForm(true)}>Hire!</Button>
      </Row>
      <Row>
        <Grid />
      </Row>
      <FormEmployee title="New" subtitle="Employee" show={showEmployeeForm} handleClose={() => setShowEmployeeForm(false)} />
    </Container>
  )
}

export default Employees