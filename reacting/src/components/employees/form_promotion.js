import { Modal, Card, Row, Col, Container, Form, Button, FloatingLabel } from "react-bootstrap"
import { useDispatch } from "react-redux";
import { useForm } from "react-hook-form"
import { promoteEmployee } from "./actions"

let FormPromotion = (props) => {
  const dispatch = useDispatch()
  const {show, handleClose} = props
  const { id, name, position } = props.show
  const {register, handleSubmit, reset} = useForm()

  return (
    <Col>
      <Modal size="md" centered show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title id="contained-modal-title-vcenter"> 
            <blockquote className="blockquote mb-0">
              <p className="mb-0">{name}</p>
              <footer className="mt-0 blockquote-footer">{position}</footer>
            </blockquote>
          </Modal.Title>
        </Modal.Header>
        <Modal.Body className="show-grid">
          <Container>
            <Form onSubmit={handleSubmit(data => dispatch([promoteEmployee({...data, id: id}), reset(), handleClose()]))}>
              <Row>
                <Card>
                  <Card.Body>
                    <Form.Group>
                      <Row>
                        <Col>
                          <Form.Group>
                            <FloatingLabel label="Position">
                              <Form.Control placeholder="Position" {...register('position')} />
                            </FloatingLabel>
                          </Form.Group>
                        </Col>
                      </Row>
                    </Form.Group>
                  </Card.Body>
                </Card>
              </Row>
              <Row>
                <Button className="mt-3" variant="success" type="submit">Advance</Button>
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

export default FormPromotion;