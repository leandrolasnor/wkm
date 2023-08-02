const Position = props => {
  const {position, working_for} = props

  return(
    <div className="c-details ms-2">
      <h6 className="mb-0 pt-1">{position}</h6> <span>Working for {working_for}</span>
    </div>
  )
}

export default Position