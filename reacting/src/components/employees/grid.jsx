import React, { useState } from 'react'
import { useSelector } from "react-redux";
import * as B from 'react-bootstrap'
import Paginator from './paginator'
import Employee from '../new_employee/component'
// import Employee from '../employee/component'
import FormVacation from "./form_vacation";
import FormPartitioned from "./form_partitioned";
import FormPromotion from "./form_promotion";

const Grid = () => {
  const employees = useSelector(state => state.employees)
  
  const [showVacationForm, setShowVacationForm] = useState(false)
  const [showPartitionedForm, setShowPartitionedForm] = useState(false)
  const [showPromotionForm, setShowPromotionForm] = useState(false)

  const list = employees.list.map((employee, index) => {
    return (
      // <Employee
      //   key={index}
      //   employee={employee}
      //   showVacationForm={props => setShowVacationForm(props)}
      //   showPartitionedForm={props => setShowPartitionedForm(props)}
      //   showPromotionForm={props => setShowPromotionForm(props)}
      // />
      <Employee />
    )
  })

  return(
    <React.Fragment>
      <B.Container>
        <B.Row className='mt-2'>
          {list}
        </B.Row>
      </B.Container>
      <Paginator />
      <FormVacation title="Vacation" show={showVacationForm} handleClose={() => setShowVacationForm(false)}/>
      <FormPartitioned title="Vacation" show={showPartitionedForm} handleClose={() => setShowPartitionedForm(false)}/>
      <FormPromotion subtitle="Promotion" show={showPromotionForm} handleClose={() => setShowPromotionForm(false)}/>
    </React.Fragment>
  )
}

export default Grid