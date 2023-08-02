import * as B from 'react-bootstrap'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faEllipsis } from '@fortawesome/free-solid-svg-icons'

const Options = props => {
  const {showVacationForm, showPromotionForm, showPartitionedForm} = props

  return(
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
  )
}

export default Options