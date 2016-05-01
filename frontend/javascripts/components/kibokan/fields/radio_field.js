import React, { Component, PropTypes } from 'react';

import BaseField from './base_field';

export default class RadioField extends BaseField {
  render() {
    const { field } = this.props;

    const items = field.options.map(({ label }) => {
      return (
        <label className="list-group-item" key={label}>
          <input type="radio" value={label} name={field.name} onChange={this.handleChange} />{label}
        </label>
      );
    });

    return (
      <div className="list-group radio">
        {items}
      </div>
    );
  }
}
