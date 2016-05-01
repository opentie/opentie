import React, { Component } from 'react';
import { Link } from 'react-router';
import { EventEmitter } from 'events';
import { Category, Entity } from 'kibokan';
import CategorizedGroupsPanel from '../components/categorized_groups_panel';
import Glyphicon from '../components/glyphicon';
import BasePage from './base_page';
import agent from '../agent';

export default class DashboardPage extends BasePage {
  fetch() {
    return Promise.resolve({});
  }

  renderContent() {
    return (
      <div>
        <div className="jumbotron">
          <h1>雙峰祭オンラインシステム</h1>
          <p>雙峰祭オンラインシステムへようこそ</p>
          <p>
            <Link className="btn btn-primary btn-lg" to="/account/new">
              <Glyphicon glyph="ok-sign" />&nbsp;
              新規登録
            </Link>
            &nbsp;
            <Link className="btn btn-default btn-lg" to="/dashboard">
              <Glyphicon glyph="ok-sign" />&nbsp;
              ログイン
            </Link>
          </p>
        </div>
      </div>
    );
  }
}
