import { Modal, Card, Row, Col, Container, Form } from "react-bootstrap"
import { reduxForm, Field, formValueSelector, reset, isPristine} from "redux-form";
import { useDispatch, useSelector, connect } from "react-redux";

const InputText = props => <Form.Control className="mb-2" autoComplete="on" {...props.input} {...props} />

let FormEmployee = (props) => {
  const {title, subtitle, show, pristine, save, submitting, handleClose} = props
  const dispatch = useDispatch()
  const seletor = formValueSelector("employeeForm");
  const name = useSelector(state => seletor(state, 'name'))
  const position = useSelector(state => seletor(state, 'position'))

  const data = {
    name: name,
    position: position
  }

  return (
    <Col>
      <Modal size="md" centered show={show} onShow={() => dispatch(reset('employeeForm'))} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title id="contained-modal-title-vcenter"> 
            <blockquote className="blockquote mb-0">
              <p className="mb-0">{title}</p>
              <footer className="mt-0 blockquote-footer">{subtitle}</footer>
            </blockquote>
          </Modal.Title>
        </Modal.Header>
        <Modal.Body className="show-grid">
          <Container>
            <Row>
              <Col lg={12}>
                <Card className="bg-dark mt-3">
                  <Card.Body>
                    <Form onSubmit={e => {save(data); e.preventDefault(); handleClose();}}>
                      <Form.Group>
                        <Col lg={12}>
                          <Field name="name" required component={InputText} placeholder="Name"/>
                        </Col>
                        <Col lg={12}>
                          <Field name="position" required component={InputText} placeholder="Position"/>
                        </Col>
                        <Col lg={6} md={12} sm={12} xs={12}>
                          <button type="submit" disabled={pristine || submitting} className="mt-2 btn btn-success btn-block pull-right font-weight-bold btn-sm">Hire!</button>
                        </Col>
                      </Form.Group>
                    </Form>
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
FormEmployee = reduxForm({ form: "employeeForm", enableReinitialize: true})(FormEmployee);
FormEmployee = connect(state => ({pristine: isPristine('employeeForm')(state)}), null)(FormEmployee)
export default FormEmployee;