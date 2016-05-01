import React, { Component, PropTypes } from 'react';
import BaseField from './base_field';
import { FieldValue } from 'kibokan';

export default class TextField extends BaseField {
  render() {
    const { field } = this.props;
    const { fieldValue } = this.state;

    return (
      <input
        type="text"
        className="form-control"
        onChange={this.handleChange}
        value={fieldValue.value} />
    );
  }
}
