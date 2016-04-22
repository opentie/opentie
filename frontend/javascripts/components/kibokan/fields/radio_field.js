import React, { Component, PropTypes } from 'react';

export default class RadioField extends Component {
  static propTypes = {
    field: PropTypes.any.isRequired,
  };

  render() {
    const { field } = this.props;

    const items = field.options.map(({ label }) => {
      return (
        <label className="list-group-item" key={label}>
          <input type="radio" value={label} name={field.name} />{label}
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
