import React, { Component } from 'react';
import { Link } from 'react-router';
import Glyphicon from '../glyphicon';

export default class Hamburger extends Component {
  render() {
    return (
      <ul className="nav navbar-nav navbar-right">
        <li>
          {
            /*
            <Link to="/settings" activeClassName="active">
              <Glyphicon glyph="menu-hamburger" />
            </Link>
            */
          }
          <Link to="/sign_out" activeClassName="active">
            <Glyphicon glyph="log-out" />
          </Link>
        </li>
      </ul>
    );
  }
}
