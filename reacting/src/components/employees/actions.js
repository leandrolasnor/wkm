import { toastr } from "react-redux-toastr";
import axios from 'axios'
import handle_errors from './handle_errors'

export const getEmployees = page => {
  return dispatch => {
    if(!page) return;
    axios.get('http://localhost:3000/employees/list', { params: { page: page, per_page: 12 } })
    .then( resp => {
      dispatch({type: 'FETCH_EMPLOYEES', payload: { employees: resp.data }})
    })
    .catch( e => handle_errors(e))
  }
}

export const createEmployee = employee => {
  return dispatch => {
    axios.post('http://localhost:3000/employee/hire', { employee })
    .then( resp => {
      dispatch({type: 'CREATED_EMPLOYEE', payload: { employee: resp.data }})
    })
    .catch( e => handle_errors(e))
  }
}

export const createVacation = vacation => {
  return dispatch => {
    axios.post('http://localhost:3000/vacation/schedule', { vacation }).then( resp => {
      toastr.success('Vacation', 'Created')
    }).catch( e => handle_errors(e))
  }
}

export const promoteEmployee = employee => {
  debugger
  return dispatch => {
    axios.patch('http://localhost:3000/employee/promotion', { employee }).then( resp => {
      let {name, position} = resp.data
      dispatch({type: 'PROMOTED_EMPLOYEE', payload: {employee: resp.data}})
      toastr.info(name + ' has been promoted to', position)
    }).catch( e => handle_errors(e))
  }
}