import React, { Component, PropTypes } from 'react';

export default class ParagraphField extends Component {
  static propTypes = {
    field: PropTypes.any.isRequired,
  };

  render() {
    const { field } = this.props;

    return (
      <textarea className="form-control"></textarea>
    );
  }
}
