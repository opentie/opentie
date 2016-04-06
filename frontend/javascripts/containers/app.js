import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { browserHistory } from 'react-router';
import Navbar from '../components/navbar';
import Breadcrumb from '../components/breadcrumb';

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
    //children.type
    return (
      <div>
        <Navbar />
        <Breadcrumb />
        <div className="container-fluid">
          <div className="row">
            {children}
          </div>
        </div>
      </div>
    );
  }
}
