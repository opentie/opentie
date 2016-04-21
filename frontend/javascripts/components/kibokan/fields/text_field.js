import React, { Component, PropTypes } from 'react';

export default class TextField extends Component {
  static propTypes = {
    field: PropTypes.any.isRequired,
  };

  render() {
    const { field } = this.props;

    return (
      <input type="text" className="form-control" />
    );
  }
}
