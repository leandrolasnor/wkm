import { Modal, Card, Row, Col, Container, Form } from "react-bootstrap"
import { reduxForm, Field, formValueSelector, reset, isPristine} from "redux-form";
import { useDispatch, useSelector, connect } from "react-redux";
import DatePicker from '../commons/date_picker/component'

let FormVacation = (props) => {
  const {title, show, pristine, save, submitting, handleClose} = props
  const dispatch = useDispatch()
  const seletor = formValueSelector("vacationForm");
  const start_date = useSelector(state => seletor(state, 'start_date'))
  const end_date = useSelector(state => seletor(state, 'end_date'))
  const { name, id } = props.show

  const data = {
    start_date: start_date,
    end_date: end_date,
    employee_id: id
  }

  const today = new Date()
  const tomorrow = new Date(today)
  tomorrow.setDate(tomorrow.getDate() + 1)

  return (
    <Col>
      <Modal size="md" centered show={show} onShow={() => dispatch(reset('vacationForm'))} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title id="contained-modal-title-vcenter"> 
            <blockquote className="blockquote mb-0">
              <p className="mb-0">{title}</p>
              <footer className="mt-0 blockquote-footer">{name}</footer>
            </blockquote>
          </Modal.Title>
        </Modal.Header>
        <Modal.Body className="show-grid">
          <Container>
            <Row>
              <Col lg={12}>
                <Card className="bg-dark mt-3">
                  <Card.Body>
                    <Form.Group>
                      <Form onSubmit={e => {save(data); e.preventDefault(); handleClose();}}>
                        <Col lg={12}>
                          <Field name="start_date" autocomplete="off" placeholder="Start Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={start_date} />
                        </Col>
                        <Col lg={12}>
                        <Field name="end_date" autocomplete="off" placeholder="End Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={end_date} />
                        </Col>
                        <Col lg={6} md={12} sm={12} xs={12}>
                          <button type="submit" disabled={pristine || submitting} className="mt-2 btn btn-success btn-block pull-right font-weight-bold btn-sm">Schedule!</button>
                        </Col>
                      </Form>
                    </Form.Group>
                  </Card.Body>
                </Card>
              </Col>
            </Row>
          </Container>
        </Modal.Body>
        <Modal.Footer>
        </Modal.Footer>
      </Modal>
    </Col>
  )
}

FormVacation = reduxForm({ form: "vacationForm", enableReinitialize: true})(FormVacation);
FormVacation = connect(state => ({pristine: isPristine('vacationForm')(state)}), null)(FormVacation)
export default FormVacation;