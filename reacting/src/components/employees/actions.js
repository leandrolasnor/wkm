import { toastr } from "react-redux-toastr";
import axios from 'axios'

export const getEmployees = page => {
  return dispatch => {
    if(!page) return;
    axios.get('http://localhost:3000/employees/list', { params: { page: page, per_page: 12 } })
    .then( resp => {
      dispatch({type: 'FETCH_EMPLOYEES', payload: { employees: resp.data }})
    })
    .catch( e => {
      toastr.error(String(e.response.status), e.response.statusText);
    })
  }
}

export const createEmployee = employee => {
  return dispatch => {
    axios.post('http://localhost:3000/employee/hire', { employee })
    .then( resp => {
      dispatch({type: 'CREATED_EMPLOYEE', payload: { employee: resp.data }})
    })
    .catch( e => {
      toastr.error(String(e.response.status), e.response.statusText);
    })
  }
}

export const createVacation = vacation => {
  return dispatch => {
    axios.post('http://localhost:3000/vacation/schedule', { vacation }).then( resp => {
      toastr.success('', 'Vacation created')
    }).catch( e => {
      if(e.response.data.availability){
        e.response.data.availability.forEach(error => {
          toastr.error('Availability', error);
        });
      }else if(e.response.data.start_date || e.response.data.end_date){
        e.response.data.start_date.forEach(error => {
          toastr.error('Start Date', error);
        });
      }else if(e.response.data.overlap){
        e.response.data.overlap.forEach(error => {
          toastr.error('Overlaped', error);
        });
      }else{
        toastr.error(String(e.response.status), e.response.statusText);
      }
    })
  }
}