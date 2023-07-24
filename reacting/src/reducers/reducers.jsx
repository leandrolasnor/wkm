import { combineReducers } from "redux";
import {reducer as toastr} from 'react-redux-toastr';
import employees from "../components/employees/reducer"

import { reducer as formReducer } from 'redux-form';

const rootReducer = combineReducers({
  employees,
  form:formReducer,
  toastr
});

export default rootReducer;