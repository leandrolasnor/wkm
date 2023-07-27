import {useForm} from 'react-hook-form'
import { Modal, Card, Row, Col, Container, Form, Button, FloatingLabel  } from "react-bootstrap"
import { useDispatch } from "react-redux";
import { createPartitionedVacation } from './actions';
import moment from 'moment'

const FormPartitioned = (props) => {
  const dispatch = useDispatch()
  const {title, show, handleClose} = props
  const { name, id } = props.show
  const {register, handleSubmit, reset} = useForm()
  const tomorrow = moment().add(1, 'days').format('YYYY-MM-DD')

  let onSubmit = fields => {
    const data = {
      employee_id: id,
      partitions: [
        { start_date: fields.start_date1, end_date: fields.end_date1 },
        { start_date: fields.start_date2, end_date: fields.end_date2 },
        { start_date: fields.start_date3, end_date: fields.end_date3 }
      ]
    }
    dispatch([createPartitionedVacation(data), reset(), handleClose()])
  }

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
            <Form onSubmit={handleSubmit(onSubmit)}>
              <Row>
                <Card>
                  <Card.Body>
                    <Form.Group>
                      <Row>
                        <Col>
                          <Form.Group>
                            <FloatingLabel label="start vacation">
                              <Form.Control type="date" min={tomorrow} {...register('start_date1')} />
                            </FloatingLabel>
                          </Form.Group>
                        </Col>
                        <Col>
                          <Form.Group>
                            <FloatingLabel label="back to work">
                              <Form.Control type="date" min={tomorrow} {...register('end_date1')} />
                            </FloatingLabel>
                          </Form.Group>
                        </Col>
                      </Row>
                      <Row>
                        <Col>
                          <Form.Text className="text-muted">Period at least 14 days</Form.Text>
                        </Col>
                      </Row>
                    </Form.Group>
                  </Card.Body>
                </Card>
                <Card className="mt-2">
                  <Card.Body>
                    <Form.Group>
                      <Row>
                        <Col>
                          <FloatingLabel label="start vacation">
                            <Form.Control type="date" min={tomorrow} {...register('start_date2')} />
                          </FloatingLabel>
                        </Col>
                        <Col>
                          <FloatingLabel label="back to work">
                            <Form.Control type="date" min={tomorrow} {...register('end_date2')} />
                          </FloatingLabel>
                        </Col>
                      </Row>
                      <Row>
                        <Col>
                          <Form.Text className="text-muted">Period at least 5 days</Form.Text>
                        </Col>
                      </Row>
                    </Form.Group>
                  </Card.Body>
                </Card>
                <Card className="mt-2">
                  <Card.Body>
                    <Form.Group>
                      <Row>
                        <Col>
                          <FloatingLabel label="start vacation">
                            <Form.Control type="date" min={tomorrow} {...register('start_date3')} />
                          </FloatingLabel>
                        </Col>
                        <Col>
                          <FloatingLabel label="back to work">
                            <Form.Control type="date" min={tomorrow} {...register('end_date3')} />
                          </FloatingLabel>
                        </Col>
                      </Row>
                      <Row>
                        <Col>
                          <Form.Text className="text-muted">Period at least 5 days</Form.Text>
                        </Col>
                      </Row>
                    </Form.Group>
                  </Card.Body>
                </Card>
              </Row>
              <Row>
                <Button className="mt-3" variant='success' type='submit'>Schedule!</Button>
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

export default FormPartitioned;