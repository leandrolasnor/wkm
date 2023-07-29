import {createGlobalStyle} from 'styled-components'

const GlobalStyle = createGlobalStyle`
  .card {
    border: none;
    border-radius: 10px
  }

  .c-details span {
    font-weight: 300;
    font-size: 13px
  }

  .icon {
    width: 50px;
    height: 50px;
    background-color: #eee;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 39px
  }

  .options {
    width: 50px;
    height: 50px;
    border-radius: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 39px;
    &:hover {
      background-color: #eee;
    }
  }

  .badge span {
    background-color: #fffbec;
    width: 60px;
    height: 25px;
    padding-bottom: 3px;
    border-radius: 5px;
    display: flex;
    color: #fed85d;
    justify-content: center;
    align-items: center
  }

  .progress {
    height: 10px;
    border-radius: 10px
  }

  .text1 {
    font-size: 14px;
    font-weight: 600
  }

  .text2 {
    color: #a5aec0
  }
`

export default GlobalStyle