import React from 'react'
import { useDispatch } from "react-redux";
import { fireEmployee } from './actions'
import styled from 'styled-components'
import { FireButton, Card, Button} from '../commons/components'

const Name = styled.div`
  padding:1px;
`
const Position = styled.div`
  padding-bottom: 20px;
`
const HireDate = styled.div`
  margin: 1px 0;
  padding-bottom: 20px;
  a {
    color: #fff;
    background-color: #71b406;
    border-radius: 4px;
    padding: 10px 30px;
    cursor: pointer;
    border-radius: 3px;
    border: 1px solid #71b406;
    text-align: center;
    line-height: 20px;
    min-height: 40px;
    margin: 7px;
    font-weight: 600;
    text-decoration: none;
}
`

const Employee = (props) => {
  const {id, name, position, hire_date, fired} = props.employee
  const {showVacationForm} = props
  const dispatch = useDispatch()

  return(
    <Card>
      <Name>
        {fired === true ? <s>{ name }</s> : <label>{ name }</label>}
      </Name>
      <Position>
        {position}
      </Position>
      {fired === true ? <label>Fired!</label> : <FireButton onClick={() => dispatch(fireEmployee(id))}>Fire!</FireButton>}
      <HireDate>
        <small>{hire_date}</small>
      </HireDate>
      <Button onClick={() => showVacationForm(props.employee)}>Vacations!</Button>
    </Card>
  )
}

export default Employee