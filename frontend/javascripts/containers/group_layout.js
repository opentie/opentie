import React, { Component, PropTypes } from 'react';

export default class GroupLayout extends Component {
  static propTypes = {
    children: PropTypes.element.isRequired,
  };

  render() {
    const { children } = this.props;
    return (
      <div className="container">
        {children}
      </div>
    );
  }
}
