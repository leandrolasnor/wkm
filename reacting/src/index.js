import React from 'react';
import ReactDOM from 'react-dom/client';
import { applyMiddleware, createStore } from "redux";
import { Provider } from "react-redux";
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import reducers from "./reducers/reducers";
import ReduxToastr from 'react-redux-toastr'
import promise from "redux-promise";
import multi from "redux-multi";
import thunk from "redux-thunk";
import 'react-redux-toastr/lib/css/react-redux-toastr.min.css';

const devTools =
  process.env.NODE_ENV === "development"
    ? window.__REDUX_DEVTOOLS_EXTENSION__ &&
      window.__REDUX_DEVTOOLS_EXTENSION__()
    : null;
const store =
  process.env.NODE_ENV === "development"
    ? applyMiddleware(multi, thunk, promise)(createStore)(reducers, devTools)
    : applyMiddleware(multi, thunk, promise)(createStore)(reducers);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
      <ReduxToastr
        timeOut={6000}
        newestOnTop={true}
        preventDuplicates
        position="top-right"
        getState={(state) => state.toastr}
        transitionIn='fadeIn'
        transitionOut='fadeOut'
        progressBar
        closeOnToastrClick/>
    </Provider>
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
