import React, { Component } from 'react';

export default class AccountsEmailSentPage extends Component {
  render() {
    return (
      <div>
        <h1>アカウント仮登録完了</h1>
        <p>入力されたメールアドレス宛てに確認メールを送信しました。メール内のリンクへアクセスして本登録を完了してください。</p>
        <p>このページは閉じて構いません。</p>
      </div>
    );
  }
}
