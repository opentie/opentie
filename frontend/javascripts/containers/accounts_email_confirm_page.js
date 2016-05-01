import React from 'react';
import { Link } from 'react-router';

import url from 'url';
import BasePage from './base_page';
import agent from '../agent';

export default class AccountsEmailConfirmPage extends BasePage {
  fetch() {
    const { query } = url.parse(location.search, true);
    const { email_set_token } = query;

    return agent.request('POST', url.format({
      pathname: 'account/email_confirm',
      query: { email_set_token },
    }));
  }

  renderContent() {
    return (
      <div>
        <h1>メールアドレスの確認が完了しました</h1>
        <div className="text-center">
          <Link to="/dashboard" className="btn btn-default">ダッシュボードへ</Link>
        </div>
      </div>
    );
  }
}
