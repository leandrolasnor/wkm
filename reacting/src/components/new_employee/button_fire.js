import React, {useEffect, useState} from 'react'
import { useDispatch } from "react-redux";
import { fireEmployee } from '../employees/actions'
import * as S from './styled.js'

const ButtonFire = props => {
  const {id, fired, working} = props.employee
  const dispatch = useDispatch()
  const [showFire, setShowFire] = useState(false)

  useEffect(() => {
    if(showFire) setTimeout(() => setShowFire(false), 3000);
  }, [showFire])

  return(
    <div>
      {!fired && !showFire && <S.Badge onClick={() => setShowFire(true)} bg="success">{working === true ? 'working' : 'enjoying'}</S.Badge>}
      {!fired && showFire && <S.Badge onClick={() => dispatch(fireEmployee(id))} bg="danger">Fire ?</S.Badge>}
      {fired && <S.Badge bg="danger">Fired</S.Badge>}
    </div>
  )
}

export default ButtonFire