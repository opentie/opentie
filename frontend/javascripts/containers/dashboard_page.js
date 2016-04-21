import React, { Component } from 'react';
import { Link } from 'react-router';
import Glyphicon from '../components/Glyphicon';

export default class DashboardPage extends Component {
  render() {
    return (
      <div className="col-xs-12 col-lg-6 col-lg-offset-3">
        <div className="row">
          <div className="table-view">
            <h3 className="table-view-caption">企画団体</h3>
            <Link to="/groups/1" className="table-view-item">tkbctf #5</Link>
            <Link
              to="/group_schemata/1/groups/new"
              className="table-view-item action action-primary">
              <Glyphicon glyph="plus" />
              &nbsp;新しい企画を登録
            </Link>
          </div>
        </div>
      </div>
    );
  }
}
