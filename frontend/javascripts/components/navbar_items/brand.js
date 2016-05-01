import React, { Component, PropTypes } from 'react';
import { IndexLink } from 'react-router';

export default class Brand extends Component {
  static propTypes = {
    link: PropTypes.string,
  };

  render() {
    return (
      <ul className="nav navbar-nav">
        <li>
          <IndexLink
            to={this.props.link || '/dashboard'}
            activeClassName="active"
            >
            <span className="openticon-logo" />
          </IndexLink>
        </li>
      </ul>
    );
  }
}
