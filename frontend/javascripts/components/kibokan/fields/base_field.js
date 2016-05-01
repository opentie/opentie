import React, { Component, PropTypes } from 'react';

import { FieldValue } from 'kibokan';

export default class BaseField extends Component {
  static propTypes = {
    field: PropTypes.any.isRequired,
    onChange: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);

    const { field } = this.props;
    this.state = { fieldValue: new FieldValue(field, null) };
  }

  handleChange(e) {
    const { field, onChange } = this.props;
    const fieldValue = new FieldValue(field, e.target.value);
    this.setState({ fieldValue });

    onChange(fieldValue);
  }
}
