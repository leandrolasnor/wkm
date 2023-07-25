import React from 'react'
import { useDispatch } from "react-redux";
import { fireEmployee } from './actions'
import { Col, Card, Button } from "react-bootstrap";

const Employee = (props) => {
  const {id, name, position, hire_date, fired} = props.employee
  const {showVacationForm} = props
  const dispatch = useDispatch()
  const Fire = props => {
    const fired = props.fired
    return (fired ? <span>Fired!</span> : <Button variant="outline-danger" onClick={() => dispatch(fireEmployee(id))}>Fire!</Button>)
  }
  const Name = props => {
    const fired = props.fired
    return (fired ? <s>{name}</s> : <h2>{ name }</h2>)
  }

  return(
    <Card bg={fired ? 'danger' : 'light'} className="my-3 mx-5">
      <Card.Body>
        <Card.Title className="d-flex justify-content-between">
          <Name fired={fired} />  
          <Col lg={1} className="d-flex justify-content-end">
            <Fire fired={fired}/>
          </Col>
        </Card.Title>
        <Card.Subtitle className="mb-2 text-muted">{position}</Card.Subtitle>
        <Card.Link href="#" onClick={() => showVacationForm(props.employee)}>Add vacation</Card.Link>
        <Card.Link href="#" onClick={() => showVacationForm(props.employee)}>Add partitioned</Card.Link>
      </Card.Body>
      <Card.Body>
        <Card.Text href="#">{hire_date}</Card.Text>
      </Card.Body>
    </Card>
  )
}

export default Employee