import React, { Component } from 'react';
import Navbar from './navbar';
import Brand from './navbar_items/brand';

export default class ToplevelNavbar extends Component {
  render() {
    return (
      <Navbar>
        <Brand />
      </Navbar>
    );
  }
}
