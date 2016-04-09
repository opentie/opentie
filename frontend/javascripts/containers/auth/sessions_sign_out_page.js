import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { browserHistory } from 'react-router';

export default class SessionsSignOutPage extends Component {
  render() {
    return (
      <div>
        <h1>auth/sessions#sign_out</h1>
        <p>This is SessionsSignOutPage in javascripts/containers/auth/sessions_sign_out_page.js</p>
      </div>
    );
  }
}
