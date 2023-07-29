import React from 'react'
import * as S from './styled.js'
import GlobalStyle from './globalstyle.js'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faImage, faEllipsis } from '@fortawesome/free-solid-svg-icons'

const Employee = props => {
  return(
    <>
      <GlobalStyle />
      <S.Col className="md-4" lg={4}>
          <S.Card className="p-3 mb-2">
              <S.Row className="d-flex justify-content-between">
                <S.Col lg={1}>
                  <div className="icon">
                    <FontAwesomeIcon size="2xs" icon={faImage} />
                  </div>
                </S.Col>
                <S.Col lg={6}>
                    <div class="ms-2 c-details">
                        <h6 class="mb-0">Senior Developer</h6> <span>Working for 10 years</span>
                    </div>
                </S.Col>
                <S.Col lg={3}>
                    <S.Badge>working</S.Badge>
                </S.Col>
              </S.Row>
              <S.Row className="mt-4">
                  <h3>Employee Name</h3>
                  <S.Col lg={12}>
                    <S.Progress now={50} animated variant="warning" />
                  </S.Col>
                  <S.Col>
                      <div class="mt-4"> <span class="text1">32 Applied <span class="text2">of 50 capacity</span></span> </div>
                  </S.Col>
              </S.Row>
              <S.Stack direction="horizontal" gap={3}>
                <div />
                <div className="ms-auto"></div>
                <div />
                <div className="options">
                  <FontAwesomeIcon size="xs" icon={faEllipsis} />
                </div>
              </S.Stack>
          </S.Card>
      </S.Col>
    </>
  )
}

export default Employee