import React, { Component } from 'react';
import Navbar from './navbar';
import Brand from './navbar_items/brand';
import Hamburger from './navbar_items/hamburger';

export default class ToplevelNavbar extends Component {
  render() {
    return (
      <Navbar>
        <Brand link="/" />
      </Navbar>
    );
  }
}
