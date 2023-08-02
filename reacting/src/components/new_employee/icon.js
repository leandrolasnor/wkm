import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faImage } from '@fortawesome/free-solid-svg-icons'

const Icon = props => {
  return(
    <div className="icon">
      <FontAwesomeIcon size="2xs" icon={faImage} />
    </div>
  )
}

export default Icon