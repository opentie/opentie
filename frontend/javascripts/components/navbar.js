'use strict';

import React, { Component } from 'react';
import { Link, IndexLink } from 'react-router';
import classnames from 'classnames';

export default class Navbar extends Component {
  render() {
    const { router } = this.context;

    return (
      <nav className="navbar navbar-default navbar-fixed-top">
        <ul className="nav navbar-nav">
          <li>
            <Link
               to="/"
               activeClassName="active"
               >
              <span className="openticon-logo" />
            </Link>
          </li>
        </ul>
        <ul className="nav navbar-nav">
          <li>
            <IndexLink
               to="/groups/:group_id"
               activeClassName="active"
               >
              <span className="glyphicon glyphicon-home" />
            </IndexLink>
          </li>
          <li>
            <Link
               to="/groups/:group_id/sub_schemata/"
               activeClassName="active"
               >
              <span className="glyphicon glyphicon-check" />
            </Link>
          </li>
          <li>
            <Link
               to="/groups/:group_id/message/topics"
               activeClassName="active"
               >
              <span className="glyphicon glyphicon-envelope" />
            </Link>
          </li>
          <li>
            <Link
               to="/groups/:group_id/files"
               activeClassName="active"
               >
              <span className="glyphicon glyphicon-paperclip" />
            </Link>
          </li>
        </ul>
        <ul className="nav navbar-nav navbar-right">
          <li>
            <Link
               to="/settings"
               activeClassName="active"
               >
              <span className="glyphicon glyphicon-menu-hamburger" />
            </Link>
          </li>
        </ul>
      </nav>
    );
  }
}

Navbar.contextTypes = {
  router: React.PropTypes.object
};
