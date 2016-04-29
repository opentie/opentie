import React, { Component, PropTypes } from 'react';

import NamedObjectMap from 'kibokan/named_object_map';
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
  };

  render() {
    const { field } = this.props;
    const FieldImpl = Mapping.get(field.constructor.name);
    const validators = field.validators.map((validator, i) => (
      <li key={i}>
        {ValidatorPrinters[validator.constructor.name](validator.parameter)}
      </li>
    ));

    return (
      <div className="form-group">
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
        <FieldImpl field={field} />
      </div>
    );
  }
}
