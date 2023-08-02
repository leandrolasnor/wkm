import ButtonFire from './button_fire'
import Options from './options'
import Icon from './icon'
import Position from './position'
import * as B from 'react-bootstrap'
import GlobalStyle from './globalstyle'
import moment from 'moment'

const vacation_progress_bar = hire_date => {
  var currentYear = moment().year()
  var currentMonth = moment().month()
  var currentDay = moment().day()

  var hireMonth = moment(hire_date).month()
  var hireDay = moment(hire_date).day()

  var a = moment([currentYear, hireMonth, hireDay])
  var b = moment([currentYear, currentMonth, currentDay])

  if (a.diff(b, 'days') < 0) b = moment([currentYear + 1, hireMonth, hireDay])
  var ratio_remaining = a.diff(b, 'days') / 365
  var percent_remaining = ratio_remaining * 100
  return percent_remaining
}

const Employee = props => {
  const {name, hire_date, vacation_days_available, enjoyed} = props.employee

  return(
    <>
      <GlobalStyle />
      <B.Col md={4} sm={12} className="mt-2 mb-2">
          <B.Card className="p-3">
            <B.Row>
              <B.Col xs={9} className="d-flex">
                <Icon />
                <Position {...props.employee} />
              </B.Col>
              <B.Col xs={3} className="d-flex flex-row-reverse">
                <ButtonFire employee={props.employee} />
              </B.Col>
            </B.Row>
            <B.Row className="mt-3">
              <B.Col xs={12}>
                <h3>{name}</h3>
              </B.Col>
              <B.Col xs={12}>
                <B.ProgressBar now={vacation_progress_bar(hire_date)} animated variant="warning" />
              </B.Col>
            </B.Row>
            <B.Row className="mt-4">
              <B.Col xs={8}>
                <div>
                  <span className="text1">{enjoyed} enjoyed <span className="text2">of {vacation_days_available} available</span></span>
                </div>  
              </B.Col>
              <B.Col xs={4} className="d-flex flex-row-reverse">
                <Options {...props} />
              </B.Col>
            </B.Row>
          </B.Card>
      </B.Col>
    </>
  )
}

export default Employee