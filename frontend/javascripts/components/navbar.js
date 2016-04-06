import React, { Component } from 'react';
import { Link, IndexLink } from 'react-router';
import Glyphicon from './glyphicon';
import NavbarGroup from './navbar_group';

export default class Navbar extends Component {
  render() {
    return (
      <nav className="navbar navbar-default navbar-fixed-top">
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
        <NavbarGroup groupId="1" />
        <ul className="nav navbar-nav navbar-right">
          <li>
            <Link
               to="/settings"
               activeClassName="active"
               >
              <Glyphicon glyph="hamburger" />
            </Link>
          </li>
        </ul>
      </nav>
    );
  }
}
