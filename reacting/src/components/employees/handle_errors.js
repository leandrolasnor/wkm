import { toastr } from "react-redux-toastr";

var _ = require('lodash')

export default e => {
  if(e.response.data){
    Object.entries(e.response.data).forEach(error => {
      const [key, value] = error;
      toastr.error(_.capitalize(key), value.join(' '));
    });
  }else{
    toastr.error(String(e.response.status), e.response.statusText);
  }
}