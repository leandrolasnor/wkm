const INITIAL_STATE = {
  list: [],
  complete: false
};

let employees;
let employee;

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
    case "PROMOTED_EMPLOYEE":
      employee = state.list.find(e => e.id === action.payload.employee.id)
      employees = state.list.filter(e => e.id !== action.payload.employee.id)
      employees = [...employees, { ...employee, position: action.payload.employee.position }].sort((a,b) => a.id - b.id)
      return {...state, list: [...employees]}
    case "EMPLOYEE_FIRED":
      employee = state.list.find(e => e.id === action.payload.employee.id)
      employees = state.list.filter(e => e.id !== action.payload.employee.id)
      employees = [...employees, { ...employee, fired: true }].sort((a,b) => a.id - b.id)
      return {...state, list: [...employees]}
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