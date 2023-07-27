import { createVacation } from "./actions"
import { Modal, Card, Row, Col, Container, Form, Button, FloatingLabel } from "react-bootstrap"
import { useDispatch } from "react-redux";
import { useForm } from "react-hook-form"
import moment from "moment"

let FormVacation = (props) => {
  const dispatch = useDispatch()
  const {title, show, handleClose} = props
  const { name, id } = props.show
  const {register, handleSubmit, reset} = useForm()
  const tomorrow = moment().add(1, "days").format("YYYY-MM-DD")

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
            <Form onSubmit={handleSubmit(data => dispatch([createVacation({...data, employee_id: id}), reset(), handleClose()]))}>
              <Row>
                <Card>
                  <Card.Body>
                    <Form.Group>
                      <Row>
                        <Col>
                          <Form.Group>
                            <FloatingLabel label="start vacation">
                              <Form.Control type="date" min={tomorrow} {...register('start_date')} />
                            </FloatingLabel>
                          </Form.Group>
                        </Col>
                        <Col>
                          <Form.Group>
                            <FloatingLabel label="back to work">
                              <Form.Control type="date" min={tomorrow} {...register('end_date')} />
                            </FloatingLabel>
                          </Form.Group>
                        </Col>
                      </Row>
                      <Row>
                        <Form.Text className="text-muted">Period at least 10 days</Form.Text>
                      </Row>
                    </Form.Group>
                  </Card.Body>
                </Card>
              </Row>
              <Row>
                <Button className='mt-3' variant="success" type="submit">Schedule</Button>
              </Row>
            </Form>
          </Container>
        </Modal.Body>
        <Modal.Footer>
        </Modal.Footer>
      </Modal>
    </Col>
  )
}

export default FormVacation;