import DatePicker from 'react-datepicker'
import 'react-datepicker/dist/react-datepicker.css';

const renderDatePicker = ({ input, label, type, className, placeholder, autocomplete, minDate, dateFormat, selected, meta: { touched, error } }) => (
  <DatePicker {...input} autoComplete={autocomplete} minDate={minDate} dateFormat={dateFormat} type={type} selected={selected} placeholderText={placeholder} />
)

export default renderDatePicker