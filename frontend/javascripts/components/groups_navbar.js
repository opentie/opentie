import React, { Component } from 'react';
import Navbar from './navbar';
import Brand from './navbar_items/brand';
import Groups from './navbar_items/groups';

export default class GroupsNavbar extends Component {
  render() {
    const { params } = this.props;
    return (
      <Navbar>
        <Brand />
        <Groups groupId={params.group_id} />
      </Navbar>
    );
  }
}
