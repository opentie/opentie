import React, { Component, PropTypes } from 'react';

import Field from './field';

export default class Form extends Component {
  static propTypes = {
    schema: PropTypes.any.isRequired,
  };

  render() {
    const { schema } = this.props;

    const fields = schema.fields.map((field) => (
      <Field key={field.name} field={field} />
    ));

    return (
      <div>
        <h2>{schema.name}</h2>
        <form>
          <p>{schema.description}</p>
          {fields}
        </form>
      </div>
    );
  }
}
