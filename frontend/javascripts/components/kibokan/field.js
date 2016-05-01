import React, { Component, PropTypes } from 'react';
import classnames from 'classnames';
import { NamedObjectMap, FieldValue } from 'kibokan';
import Fields from './fields';

const Mapping = new NamedObjectMap();
Mapping.add(Fields.TextField);
Mapping.add(Fields.ParagraphField);
Mapping.add(Fields.RadioField);

const ValidatorPrinters = {
  MaxlengthValidator: (length) => `${length}文字以内`,
};

export default class Field extends Component {
  static propTypes = {
    field: PropTypes.any.isRequired,
    onChange: PropTypes.func.isRequired,
  };

  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);

    const { field } = this.props;
    this.state = { fieldValue: new FieldValue(field, null) };
  }

  handleChange(fieldValue) {
    this.setState({ fieldValue });
    this.props.onChange(fieldValue);
  }

  render() {
    const { field } = this.props;
    const { fieldValue } = this.state;
    const FieldImpl = Mapping.get(field.constructor.name);
    const validators = fieldValue.validities.map(({ validator, validity }, i) => (
      <li key={i} className={classnames({ 'text-danger': !validity })}>
        {ValidatorPrinters[validator.constructor.name](validator.threshold)}
      </li>
    ));

    return (
      <div className={classnames('form-group', { 'has-error': !fieldValue.isValid })}>
        <label>
          {field.name}
          {(() => {
            if (field.isRequired) {
              return (
                <span className="label label-danger">必須</span>
              );
            }
            return null;
          })()}
        </label>
        {(() => {
          if (field.description !== null) {
            return (
              <p className="help-block">{field.description}</p>
            );
          }
          return null;
        })()}
        <ul>
          {validators}
        </ul>
        <FieldImpl field={field} onChange={this.handleChange} />
      </div>
    );
  }
}
