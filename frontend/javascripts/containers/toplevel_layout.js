import React, { Component, PropTypes } from 'react';

export default class ToplevelLayout extends Component {
  static propTypes = {
    children: PropTypes.element.isRequired,
  };

  render() {
    const { children } = this.props;
    return (
      <div className="container-fluid">
        <div className="row">
          {children}
        </div>
      </div>
    );
  }
}
