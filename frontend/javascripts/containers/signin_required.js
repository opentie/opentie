import React, { Component, PropTypes } from 'react';
import SigninModal from '../components/signin_modal';
import agent from '../agent';

export default class SigninRequired extends Component {
  static propTypes = {
    children: PropTypes.element.isRequired,
  };

  constructor(props) {
    super(props);

    this.state = { isSignedin: false };
    this.handleLogin = this.handleLogin.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  componentWillMount() {
    agent.on('change', this.handleChange);
    this.handleChange();
  }

  componentWillUnmount() {
    agent.removeListener('change', this.handleChange);
  }

  handleLogin(email, password) {
    agent.request('POST', 'sessions/sign_in', {
      email, password
    });
  }

  handleChange() {
    const { isSignedin } = agent;
    this.setState({ isSignedin });
  }

  render() {
    const { children } = this.props;
    const { isSignedin } = this.state;

    return (
      <div>
        { isSignedin && children }
        { !isSignedin && <SigninModal onLogin={this.handleLogin} /> }
      </div>
    );
  }
}
