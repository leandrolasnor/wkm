import styled from 'styled-components'

export const Button = styled.button`
  display: inline-block;
  outline: none;
  cursor: pointer;
  padding: 0 16px;
  background-color: #0070d2;
  border-radius: 0.25rem;
  border: 1px solid #0070d2;
  color: #fff;
  font-size: 13px;
  line-height: 30px;
  font-weight: 400;
  text-align: center;
  &:hover {
      background-color: #005fb2;  
      border-color: #005fb2;
  } 
`
export const IncreaseButton = styled(Button)`
  background-color: #008000;
  &:hover {
    background-color: #060;
    border-color: #00a000;
  } 
`
export const FireButton = styled(Button)`
  background-color: #f00;
  border: 1px solid #e8472e;
  color: #fff;
  &:hover {
      background-color: #c82e16;  
      border-color: #c82e16;
  } 
`
export const Home = styled.div`
  text-align:center;
`
export const Header = styled.div`
  padding:100px 100px 10px 100px;
  
  h1 {
    font-size:42px;
  }
`
export const Subheader = styled.p`
  font-weight:300;
  font-size:26px;
`
export const Grid = styled.div`
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 20px;
  width: 100%;
  padding:20px;
`

export const Card = styled.div`
  border: 1px solid #efefef;
  background: #fff;
  font-family: sans-serif;
`

