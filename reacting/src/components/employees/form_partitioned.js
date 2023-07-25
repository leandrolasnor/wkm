import { Modal, Card, Row, Col, Container, Form } from "react-bootstrap"
import { reduxForm, Field, formValueSelector, reset, isPristine} from "redux-form";
import { useDispatch, useSelector, connect } from "react-redux";
import DatePicker from '../commons/date_picker/component'

let FormPartitioned = (props) => {
  const {title, show, pristine, save, submitting, handleClose} = props
  const dispatch = useDispatch()
  const seletor = formValueSelector("partitionedForm");

  const start_date1 = useSelector(state => seletor(state, 'start_date1'))
  const end_date1 = useSelector(state => seletor(state, 'end_date1'))

  const start_date2 = useSelector(state => seletor(state, 'start_date2'))
  const end_date2 = useSelector(state => seletor(state, 'end_date2'))

  const start_date3 = useSelector(state => seletor(state, 'start_date3'))
  const end_date3 = useSelector(state => seletor(state, 'end_date3'))

  const { name, id } = props.show

  const data = {
    employee_id: id,
    partitions: [
       { start_date: start_date1, end_date: end_date1 },
       { start_date: start_date2, end_date: end_date2 },
       { start_date: start_date3, end_date: end_date3 }
    ]
  }

  const today = new Date()
  const tomorrow = new Date(today)
  tomorrow.setDate(tomorrow.getDate() + 1)

  return (
    <Col>
      <Modal size="md" centered show={show} onHide={handleClose}>
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
                <Form onSubmit={e => {save(data); dispatch(reset('partitionedForm')); e.preventDefault(); handleClose();}}>
                  <Card className="bg-dark mt-3">
                    <Card.Body>
                      <Form.Group>
                          <Col lg={12}>
                            <Field name="start_date1" autocomplete="off" placeholder="Start Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={start_date1} />
                          </Col>
                          <Col lg={12}>
                          <Field name="end_date1" autocomplete="off" placeholder="End Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={end_date1} />
                          </Col>
                      </Form.Group>
                    </Card.Body>
                  </Card>
                  <Card className="bg-dark mt-3">
                    <Card.Body>
                      <Form.Group>
                          <Col lg={12}>
                            <Field name="start_date2" autocomplete="off" placeholder="Start Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={start_date2} />
                          </Col>
                          <Col lg={12}>
                          <Field name="end_date2" autocomplete="off" placeholder="End Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={end_date2} />
                          </Col>
                      </Form.Group>
                    </Card.Body>
                  </Card>
                  <Card className="bg-dark mt-3">
                    <Card.Body>
                      <Form.Group>
                          <Col lg={12}>
                            <Field name="start_date3" autocomplete="off" placeholder="Start Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={start_date3} />
                          </Col>
                          <Col lg={12}>
                          <Field name="end_date3" autocomplete="off" placeholder="End Date" minDate={tomorrow} dateFormat="yyyy-MM-dd" component={DatePicker} selected={end_date3} />
                          </Col>
                      </Form.Group>
                    </Card.Body>
                  </Card>
                  <Col lg={6} md={12} sm={12} xs={12}>
                    <button type="submit" disabled={pristine || submitting} className="mt-2 btn btn-success btn-block pull-right font-weight-bold btn-sm">Schedule!</button>
                  </Col>
                </Form>
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

FormPartitioned = reduxForm({ form: "partitionedForm", enableReinitialize: true})(FormPartitioned);
FormPartitioned = connect(state => ({pristine: isPristine('partitionedForm')(state)}), null)(FormPartitioned)
export default FormPartitioned;