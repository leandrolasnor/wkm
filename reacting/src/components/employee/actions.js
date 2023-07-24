import { toastr } from "react-redux-toastr";
import axios from 'axios'

export const fireEmployee = id => {
  return dispatch => {
    axios.delete('http://localhost:3000/employee/fire', { data: {employee_id: id} } )
    .then( resp => {
      dispatch({type: 'EMPLOYEE_FIRED', payload: { employee: resp.data }})
    })
    .catch( e => {
      if (e.response) {
        if (e.response.data.employee_id) {
          e.response.data.employee_id.forEach(error =>
            toastr.error("Enjoying Vacation", error)
          );
        } else {
          toastr.error(String(e.response.status), e.response.statusText);
        }
      } else if (e.request) {
        if (e.message === "Network Error") {
          toastr.error("Erro", "Servidor OFFLINE");
        }
      }
    })
  }
}