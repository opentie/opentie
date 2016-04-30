import React, { Component, PropTypes } from 'react';
import { Link } from 'react-router';

import Glyphicon from './glyphicon';

export default class CategorizedGroupsPanel extends Component {
  static propTypes = {
    category: PropTypes.any.isRequired,
    groups: PropTypes.array.isRequired,
  };

  renderListGroupItem(group) {
    return (
      <Link className="list-group-item" key={group.id} to={`/groups/${group.id}`}>
        {group.id}
      </Link>
    );
  }

  render() {
    const { category, groups } = this.props;

    const listGroupItems = groups.map(this.renderListGroupItem.bind(this));

    return (
      <div className="panel panel-default" key={category.name}>
        <div className="panel-heading">{category.name}一覧</div>
        <ul className="list-group">{listGroupItems}</ul>
        <div className="panel-footer text-center">
          <Link
            to={`/categories/${category.name}/groups/new`}
            className="btn btn-primary">
            <Glyphicon glyph="plus"/> 新しい{category.name}を登録
          </Link>
        </div>
      </div>
    );
  }
}
