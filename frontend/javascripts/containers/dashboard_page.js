import React, { Component } from 'react';
import { Link } from 'react-router';
import Glyphicon from '../components/glyphicon';
import * as actions from '../actions';

export default class DashboardPage extends Component {
  componentWillMount() {
    //this.props.loadAccount();
  }

  divisionsPanel() {
    const { divisions } = this.props;

    if (!divisions) {
      return null;
    }

    const divisionItems = divisions.map((division) => {
      return (
        <Link className="list-group-item" to={`/divisions/${division.id}`}>
          {division.name}
        </Link>
      );
    });

    return (
      <div className="panel panel-default">
        <div className="panel-heading">実行委員会内組織一覧</div>
        <ul className="list-group">
          {divisionItems}
        </ul>
      </div>
    );
  }

  render() {
    const categories = [
      {
        name: '企画',
        entities: [
          {
            id: '368c9d8d-cd84-4171-afa9-9c115997f335',
            name: 'tkbctf #5',
          },
          {
            id: 'c1d022ed-1628-4974-b134-d9e8c12a5108',
            name: 'coinsLT #100',
          }
        ]
      },
      {
        name: 'OC参加団体',
        entities: [
          {
            id: 'c556418e-ae27-4d59-ab91-0f0c60db61d7',
            name: 'なんらか',
          }
        ]
      }
    ];

    const categoryPanels = categories.map((category) => {
      const groups = category.entities.map((group) => {
        return (
          <Link className="list-group-item" key={group.id} to={`/groups/${group.id}`}>
            {group.name}
          </Link>
        );
      });

      return (
        <div className="panel panel-default" key={category.name}>
          <div className="panel-heading">{category.name}一覧</div>
          <ul className="list-group">{groups}</ul>
          <div className="panel-footer text-center">
            <Link
              to={`/categories/${category.name}/groups/new`}
              className="btn btn-primary">
              <Glyphicon glyph="plus"/> 新しい{category.name}を登録
            </Link>
          </div>
        </div>
      );
    });

    return (
      <div className="row">
        <div className="col-lg-8 col-lg-offset-2">
          {categoryPanels}
        </div>
      </div>
    );
  }
}
