import { combineReducers } from "redux";
import {reducer as toastr} from 'react-redux-toastr';
import employees from "../components/employees/reducer"

const rootReducer = combineReducers({
  employees,
  toastr
});

export default rootReducer;