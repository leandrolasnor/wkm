import { Modal, Card, Row, Col, Container, Form, FloatingLabel, Button } from "react-bootstrap"
import { useDispatch } from "react-redux";
import { useForm } from "react-hook-form"
import { createEmployee } from "./actions"

let FormEmployee = (props) => {
  const dispatch = useDispatch()
  const {title, subtitle, show, handleClose} = props
  const {register, handleSubmit, reset} = useForm()

  return (
    <Col>
      <Modal size="md" centered show={show} onHide={handleClose}>
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
            <Form onSubmit={handleSubmit(data => dispatch([createEmployee(data), reset(), handleClose()]))}>
              <Row>
                <Card>
                  <Card.Body>
                    <Form.Group>
                      <FloatingLabel label="Name">
                        <Form.Control placeholder="Name" {...register('name')} />
                      </FloatingLabel>
                      <FloatingLabel label="Position">
                        <Form.Control className="mt-4" placeholder="Position" {...register('position')} />
                      </FloatingLabel>
                    </Form.Group>
                  </Card.Body>
                </Card>
              </Row>
              <Row>
                <Button className="mt-3" variant="success" type="submit">Hire</Button>                
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

export default FormEmployee;