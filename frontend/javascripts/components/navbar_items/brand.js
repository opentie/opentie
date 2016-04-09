import React, { Component } from 'react';
import { IndexLink } from 'react-router';

export default class Brand extends Component {
  render() {
    return (
      <ul className="nav navbar-nav">
        <li>
          <IndexLink
            to="/"
            activeClassName="active"
            >
            <span className="openticon-logo" />
          </IndexLink>
        </li>
      </ul>
    );
  }
}
