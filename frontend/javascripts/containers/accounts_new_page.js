import React from 'react';
import { browserHistory } from 'react-router';
import classnames from 'classnames';
import { Entity } from 'kibokan';
import BasePage from './base_page';
import agent from '../agent';
import Form from '../components/kibokan/form';

export default class AccountsNewPage extends BasePage {
  fetch() {
    return agent.request('GET', 'account/new');
  }

  constructor(props) {
    super(props);

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleEmail = this.handleEmail.bind(this);
    this.handlePassword = this.handlePassword.bind(this);
    this.handlePasswordConfirmation = this.handlePasswordConfirmation.bind(this);
  }

  handleSubmit(formValue) {
    const { email, password, passwordConfirmation } = this.state;

    if (password !== passwordConfirmation) {
      return;
    }
    const entity = new Entity();
    entity.metadata = {};
    entity.document = {
      [formValue.name]: formValue.value
    };
    agent.request('POST', 'account', {
      account: {
        email,
        password,
        password_confirmation: passwordConfirmation,
      },
      kibokan: entity.serialize(),
    }).then(() => {
      this.props.history.push('/account/email_sent');
    });
  }

  handleEmail(e) {
    this.setState({ email: e.target.value });
  }

  handlePassword(e) {
    this.setState({ password: e.target.value });
  }

  handlePasswordConfirmation(e) {
    this.setState({ passwordConfirmation: e.target.value });
  }

  renderContent() {
    const { payload, email, password, passwordConfirmation } = this.state;

    const entity = new Entity().deserialize(payload.entity);
    const form = [ ...entity.retrieveAttachableFormsMap().values() ][0];

    return (
      <div>
        <h1>アカウント登録</h1>
        <Form form={form} onSubmit={this.handleSubmit}>
          <div className="form-group">
            <label>
              メールアドレス
              <span className="label label-danger">必須</span>
            </label>
            <p className="help-block">受信できるメールアドレスを入力してください。このメールアドレスはログイン時にも使用します。</p>
            <input className="form-control" onChange={this.handleEmail} value={email} />
          </div>
          <div className="form-group">
            <label>
              パスワード
              <span className="label label-danger">必須</span>
            </label>
            <p className="help-block">アカウントのパスワードを決めてください。</p>
            <input className="form-control" type="password" onChange={this.handlePassword} value={password} />
          </div>
          <div className={classnames('form-group', { 'has-error': password !== passwordConfirmation })}>
            <label>
              パスワード確認
              <span className="label label-danger">必須</span>
            </label>
            <p className="help-block">確認のため、上記で入力したパスワードをもう一度入力してください。</p>
            <input className="form-control" type="password" onChange={this.handlePasswordConfirmation} value={passwordConfirmation} />
          </div>
        </Form>
      </div>
    );
  }
}
