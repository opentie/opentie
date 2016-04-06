import React, { Component } from 'react';
import classnames from 'classnames';

export default class Glyphicon extends Component {
  render() {
    const { glyph } = this.props;
    return (
      <span className={classnames('glyphicon', `glyphicon-${glyph}`)} />
    );
  }
}
