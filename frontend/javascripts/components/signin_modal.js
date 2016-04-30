import React, { Component, PropTypes } from 'react';

export default class SigninModal extends Component {
  static propTypes = {
    onLogin: PropTypes.func.isRequired,
  };

  constructor(props) {
    super(props);

    this.handleLogin = this.handleLogin.bind(this);
    this.handleEmailChange = this.handleEmailChange.bind(this);
    this.handlePasswordChange = this.handlePasswordChange.bind(this);

    this.state = { email: '', password: '' };
  }

  handleLogin(e) {
    e.preventDefault();
    const { email, password } = this.state;
    this.props.onLogin(email, password);
  }

  handleEmailChange(e) {
    this.setState({ email: e.target.value });
  }

  handlePasswordChange(e) {
    this.setState({ password: e.target.value });
  }

  render() {
    const { email, password } = this.state;

    return (
      <div className="modal" style={{ display: 'block' }}>
        <div className="modal-dialog">
          <form className="modal-content" onSubmit={this.handleLogin}>
            <div className="modal-header">
              <h4 className="modal-title">ログイン</h4>
            </div>
            <div className="modal-body">
              <div className="form-group">
                <label htmlFor="login-modal-email" className="control-label">メールアドレス:</label>
                <input
                  type="text"
                  className="form-control"
                  id="login-modal-email"
                  name="email"
                  value={email}
                  onChange={this.handleEmailChange} />
              </div>
              <div className="form-group">
                <label htmlFor="login-modal-password" className="control-label">パスワード:</label>
                <input
                  type="password"
                  className="form-control"
                  id="login-modal-password"
                  name="password"
                  value={password}
                  onChange={this.handlePasswordChange} />
              </div>
            </div>
            <div className="modal-footer">
              <a href="#" className="btn btn-default">パスワードを忘れた</a>
              <button className="btn btn-primary">ログイン</button>
            </div>
          </form>
        </div>
      </div>
    );
  }
}
