import React, { Component } from 'react';
import { Provider } from 'react-redux';
import DevTools from './dev_tools';
import { Router } from 'react-router';
import routes from '../routes';

export default class Root extends Component {
  render() {
    const { store, history } = this.props;
    return (
      <Provider store={store}>
        <div>
          <Router history={history} routes={routes} />
          <DevTools />
        </div>
      </Provider>
    );
  }
}