import React, { Component, PropTypes } from 'react';

export default class MessageLayout extends Component {
  static propTypes = {
    children: PropTypes.element.isRequired,
  };

  render() {
    const { children } = this.props;
    return (
      <div>
          {children}
      </div>
    );
  }
}
