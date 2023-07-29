import React from 'react'
import * as S from './styled.js'
import GlobalStyle from './globalstyle.js'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faImage, faEllipsis } from '@fortawesome/free-solid-svg-icons'

const Employee = props => {
  return(
    <>
      <GlobalStyle />
      <S.Col lg={4} md={6} sm={12}>
          <S.Card className="p-3 mb-2">
            <S.Row className="d-flex">
              <S.Col sm={2} xs={3}>
                <div className="icon">
                  <FontAwesomeIcon size="2xs" icon={faImage} />
                </div>
              </S.Col>
              <S.Col sm={7} xs={8} md={12}>
                  <div class="c-details">
                      <h6 class="mb-0 pt-1">Senior Developer</h6> <span>Working for 10 years</span>
                  </div>
              </S.Col>
              <S.Col sm={3} md={12} className="d-flex justify-content-end">
                <S.Badge>working</S.Badge>
              </S.Col>
            </S.Row>
            <S.Row className="mt-4">
                <h3>Employee Name</h3>
                <S.Col lg={12}>
                  <S.Progress now={50} animated variant="warning" />
                </S.Col>
            </S.Row>
            <S.Stack className="mt-4" direction="horizontal" gap={3}>
              <div> <span class="text1">32 Applied <span class="text2">of 50 capacity</span></span> </div>
              <div className="ms-auto"></div>
              <div />
              <div className="options">
                <FontAwesomeIcon size="2xs" icon={faEllipsis} />
              </div>
            </S.Stack>
          </S.Card>
      </S.Col>
    </>
  )
}

export default Employee