import { toastr } from "react-redux-toastr";

var _ = require('lodash')

const handle_errors = e => {
  if(_.get(e, 'response.data', false)){
    Object.entries(e.response.data).forEach(error => {
      const [key, value] = error;
      if(Array.isArray(value)) return toastr.error(_.capitalize(key), value.join(' '));
      toastr.error(_.capitalize(key), JSON.stringify(value).replace(/,|\d|:|[|]|"|{|}/g, ' '));
    });
  }else if(_.get(e, 'response', false)){
    toastr.error(String(e.response.status), e.response.statusText);
  }else if(_.get(e, 'message', false) === 'Network Error'){
    toastr.error('API', e.message);
  }else{
    toastr.error('Error', _.get(e, 'message', 'unknown error'));
  }
}

export default handle_errors