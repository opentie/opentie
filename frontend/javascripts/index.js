import 'babel-polyfill';
import 'isomorphic-fetch';
import objectValues from 'object.values';
import React from 'react';
import { render } from 'react-dom';
import { Router, browserHistory } from 'react-router';
import routes from './routes';

if (!Object.values) {
  objectValues.shim();
}

render(
  <Router history={browserHistory} routes={routes} />,
  document.getElementById('root')
);
