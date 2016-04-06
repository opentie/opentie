import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { browserHistory } from 'react-router';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleDismissClick = this.handleDismissClick.bind(this);
  }

  handleDismissClick(e) {
    this.props.resetErrorMessage();
    e.preventDefault();
  }

  handleChange(nextValue) {
    browserHistory.push(`/${nextValue}`);
  }

  render() {
    const { children, inputValue } = this.props;
    return (
      <div>
        hey
        <hr />
        {children}
      </div>
    );
  }
}
