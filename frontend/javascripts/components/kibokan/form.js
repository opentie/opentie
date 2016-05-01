import React, { Component, PropTypes } from 'react';

import Field from './field';
import { FormValue } from 'kibokan';

export default class Form extends Component {
  static propTypes = {
    form: PropTypes.any.isRequired,
    onSubmit: PropTypes.func.isRequired,
    onChange: PropTypes.func,
    children: PropTypes.arrayOf(PropTypes.element),
  };

  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);

    const { form } = this.props;
    this.state = { formValue: new FormValue(form, {}) };
  }

  handleChange(fieldValue) {
    const { form } = this.props;
    const formValue = new FormValue(form, Object.assign({}, this.state.formValue.value, {
      [fieldValue.name]: fieldValue.value
    }));

    this.setState({ formValue });
  }

  handleSubmit(e) {
    e.preventDefault();
    const { formValue } = this.state;
    if (!formValue.isValid) {
      return;
    }

    this.props.onSubmit(formValue);
  }

  render() {
    const { form, children } = this.props;

    const { formValue } = this.state;

    const fields = form.fields.map((field) => {
      return (
        <Field key={field.name} field={field} onChange={this.handleChange} />
      );
    });

    return (
      <div>
        <h2>{form.name}</h2>
        <form onSubmit={this.handleSubmit}>
          <p>{form.description}</p>
          {children}
          {fields}
          <div className="text-right">
            <button className="btn btn-primary" disabled={!formValue.isValid}>送信</button>
          </div>
        </form>
      </div>
    );
  }
}
