const INITIAL_STATE = {
  list: [],
  complete: false
};

var reducer = (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case "FETCH_EMPLOYEES":
      return {
        ...state,
        list: [
          ...state.list,
          ...action.payload.employees
        ],
        complete: action.payload.employees.length === 0
      }
    case "EMPLOYEE_FIRED":
      let employee = state.list.find(e => e.id === action.payload.employee.id)
      employee.fired = true
      return {...state}
    case "CREATED_EMPLOYEE":
      return {
        ...state,
        list: [action.payload.employee, ...state.list]
      }
    default:
      return state;
  }
}

export default reducer;