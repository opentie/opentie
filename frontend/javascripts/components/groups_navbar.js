import React, { Component, PropTypes } from 'react';
import Navbar from './navbar';
import Brand from './navbar_items/brand';
import Groups from './navbar_items/groups';
import Hamburger from './navbar_items/hamburger';

export default class GroupsNavbar extends Component {
  static propTypes = {
    params: PropTypes.object.isRequired,
  };

  render() {
    const { params } = this.props;
    return (
      <Navbar>
        <Brand />
        <Groups groupId={params.group_id} />
        <Hamburger />
      </Navbar>
    );
  }
}
