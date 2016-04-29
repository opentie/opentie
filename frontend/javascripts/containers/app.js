import React, { Component, PropTypes } from 'react';
// import { browserHistory } from 'react-router';
// import Breadcrumb from '../components/breadcrumb';

export default class App extends Component {
  static propTypes = {
    navbar: PropTypes.element.isRequired,
    main: PropTypes.element.isRequired,
  };

  render() {
    const { main, navbar } = this.props;

    return (
      <div>
        {navbar}
        {
          // TODO: Implement breadcrumb
          // <Breadcrumb />
        }
        {main}
      </div>
    );
  }
}
