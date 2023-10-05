import { toastr } from "react-redux-toastr";
import axios from 'axios'
import handle_errors from './handle_errors'

var _ = require('lodash')

export const getEmployees = page => {
  return dispatch => {
    if(!page) return;
    axios.get('/employees/list', { params: { page: page, per_page: 12 } })
    .then( resp => {
      dispatch({type: 'FETCH_EMPLOYEES', payload: { employees: resp.data }})
    })
    .catch( e => handle_errors(e))
  }
}

export const createEmployee = employee => {
  return dispatch => {
    axios.post('/employee/hire', { employee })
    .then( resp => {
      dispatch({type: 'CREATED_EMPLOYEE', payload: { employee: resp.data }})
      toastr.success('New Employee', _.get(resp.data, 'name', 'Created!'))
    })
    .catch( e => handle_errors(e))
  }
}

export const createVacation = vacation => {
  return dispatch => {
    axios.post('/vacation/schedule', { vacation }).then( resp => {
      toastr.success('Vacation', 'Created')
    }).catch( e => handle_errors(e))
  }
}

export const promoteEmployee = employee => {
  return dispatch => {
    axios.patch('/employee/promotion', employee).then( resp => {
      let {name, position} = resp.data
      dispatch({type: 'PROMOTED_EMPLOYEE', payload: {employee: resp.data}})
      toastr.success(name + ' has been promoted to', position)
    }).catch( e => handle_errors(e))
  }
}

export const createPartitionedVacation = partitioned => {
  return dispatch => {
    axios.post('/vacation/partitioned_schedule', { ...partitioned }).then( resp => {
      toastr.success('Partitioned Vacation', 'Created!')
    }).catch( e => handle_errors(e))
  }
}

export const fireEmployee = id => {
  return dispatch => {
    axios.delete('/employee/fire', { data: {employee_id: id } } )
    .then( resp => {
      dispatch({type: 'EMPLOYEE_FIRED', payload: { employee: resp.data }})
    })
    .catch( e => handle_errors(e))
  }
}