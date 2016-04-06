import React, { Component } from 'react';
import { Link, IndexLink } from 'react-router';
import Glyphicon from './glyphicon';

export default class Navbar extends Component {
  render() {
    const { groupId } = this.props;

    return (
      <ul className="nav navbar-nav">
        <li>
          <IndexLink
             to={`/groups/${groupId}`}
             activeClassName="active"
             >
            <Glyphicon glyph="home" />
          </IndexLink>
        </li>
        <li>
          <Link
             to={`/groups/${groupId}/sub_schemata/`}
             activeClassName="active"
             >
            <Glyphicon glyph="check" />
          </Link>
        </li>
        <li>
          <Link
             to={`/groups/${groupId}/message/topics`}
             activeClassName="active"
             >
            <Glyphicon glyph="envelope" />
          </Link>
        </li>
        <li>
          <Link
             to={`/groups/${groupId}/files`}
             activeClassName="active"
             >
            <Glyphicon glyph="paperclip" />
          </Link>
        </li>
      </ul>
    );
  }
}
