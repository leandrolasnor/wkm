import React from 'react'
import { useDispatch } from "react-redux";
import { fireEmployee } from '../employees/actions'
import { Col, Card, Button } from "react-bootstrap";
import styled from 'styled-components'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faUser } from '@fortawesome/free-solid-svg-icons'

const OpaqueCard = styled(Card)`
  background-color: rgba(230, 250, 200, 0.6)
`
const ButtonFire = props => {
  const {fired, onClick} = props
  return (fired ? <span>Fired!</span> : <Button variant="outline-danger" onClick={onClick}>Fire!</Button>)
}
const Name = props => {
  const {fired, name} = props
  return (fired ? <s>{name}</s> : <h2>{ name }</h2>)
}

const Employee = (props) => {
  const dispatch = useDispatch()

  const {id, name, position, hire_date, fired} = props.employee
  const {showVacationForm, showPromotionForm, showPartitionedForm} = props

  return(
    <OpaqueCard bg={fired ? 'danger' : ''} className="my-2">
      <Card.Body>
        <Card.Title className="d-flex justify-content-between">
          <Name fired={fired} name={name} />  
          <Col lg={1} className="d-flex justify-content-end">
            <ButtonFire fired={fired} onClick={() => dispatch(fireEmployee(id))}/>
          </Col>
        </Card.Title>
        <Card.Subtitle className="mb-2 text-muted">
        {position} <Card.Link href="#" onClick={() => showPromotionForm(props.employee)}><FontAwesomeIcon icon={faUser} /></Card.Link>
        </Card.Subtitle>
        <Card.Link href="#" onClick={() => showVacationForm(props.employee)}>Schedule</Card.Link>
        <Card.Link href="#" onClick={() => showPartitionedForm(props.employee)}>Partitioned Schedule</Card.Link>
      </Card.Body>
      <Card.Body>
        <Card.Text href="#">{hire_date}</Card.Text>
      </Card.Body>
    </OpaqueCard>
  )
}

export default Employee