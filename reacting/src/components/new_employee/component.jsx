import React, { useState, useEffect } from 'react'
import { useDispatch } from "react-redux";
import { fireEmployee } from '../employees/actions'
import * as B from 'react-bootstrap'
import * as S from './styled.js'
import GlobalStyle from './globalstyle.js'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faImage, faEllipsis } from '@fortawesome/free-solid-svg-icons'
import moment from 'moment'

const vacation_progress_bar = hire_date => {
  var currentYear = moment().year()
  var currentMonth = moment().month()
  var currentDay = moment().day()

  var hireMonth = moment(hire_date).month()
  var hireDay = moment(hire_date).day()

  var a = moment([currentYear, currentMonth, currentDay])
  var b = moment([currentYear, hireMonth, hireDay])
  if (a.diff(b, 'days') < 0) b = moment([currentYear + 1, hireMonth, hireDay])
  var ratio_remaining = a.diff(b, 'days') / 365
  var percent_remaining = ratio_remaining * 100
  return percent_remaining
}

const Employee = props => {
  const dispatch = useDispatch()
  const {id, fired, name, position, hire_date, working_for, vacation_days_available, enjoyed, working} = props.employee
  const {showVacationForm, showPromotionForm, showPartitionedForm} = props
  const [showFire, setShowFire] = useState(false)

  useEffect(() => {
    if(showFire) setTimeout(() => setShowFire(false), 3000);
  }, [showFire])

  return(
    <>
      <GlobalStyle />
      <B.Col md={4} sm={12} className="mt-2 mb-2">
          <B.Card className="p-3">
            <B.Row>
              <B.Col xs={9} className="d-flex">
                <div className="icon">
                  <FontAwesomeIcon size="2xs" icon={faImage} />
                </div>
                <div className="c-details ms-2">
                  <h6 className="mb-0 pt-1">{position}</h6> <span>Working for {working_for}</span>
                </div>
              </B.Col>
              <B.Col xs={3} className="d-flex flex-row-reverse">
                {!fired && !showFire && <S.Badge onClick={() => setShowFire(true)} bg="success">{working === true ? 'working' : 'enjoying'}</S.Badge>}
                {!fired && showFire && <S.Badge onClick={() => dispatch(fireEmployee(id))} bg="danger">Fire ?</S.Badge>}
                {fired && <S.Badge bg="danger">Fired</S.Badge>}
              </B.Col>
            </B.Row>
            <B.Row className="mt-4">
                <h3>{name}</h3>
                <B.Col>
                  <B.ProgressBar now={vacation_progress_bar(hire_date)} animated variant="warning" />
                </B.Col>
            </B.Row>
            <B.Stack className="mt-4" direction="horizontal" gap={3}>
              <div> <span className="text1">{enjoyed} enjoyed <span className="text2">of {vacation_days_available} available</span></span> </div>
              <div className="ms-auto"></div>
              <div />
              <B.NavDropdown className="options" title={<FontAwesomeIcon size="2xs" icon={faEllipsis} />} id="basic-nav-dropdown">
                <B.NavDropdown.Item
                  href="#"
                  onClick={() => showPromotionForm(props.employee)}
                >Promote</B.NavDropdown.Item>
                <B.NavDropdown.Item
                  href="#"
                  onClick={() => showVacationForm(props.employee)}
                >Simple Vacation</B.NavDropdown.Item>
                <B.NavDropdown.Item
                  href="#"
                  onClick={() => showPartitionedForm(props.employee)}
                >Partitioned Vacation</B.NavDropdown.Item>
              </B.NavDropdown>
            </B.Stack>
          </B.Card>
      </B.Col>
    </>
  )
}

export default Employee