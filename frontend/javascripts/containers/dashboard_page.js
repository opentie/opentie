import React, { Component } from 'react';
import { Link } from 'react-router';
import Loader from 'react-loader';
import { EventEmitter } from 'events';
import { Category, Entity } from 'kibokan';
import CategorizedGroupsPanel from '../components/categorized_groups_panel';
import Glyphicon from '../components/glyphicon';
import BasePage from './base_page';
import agent from '../agent';

export default class DashboardPage extends BasePage {
  fetch() {
    return agent.request('GET', 'account');
  }

  renderContent() {
    const { payload } = this.state;
    const categorizedGroupsList = payload.categories.map(serialized => {
      const category = new Category().deserialize(serialized);
      const groups = payload.groups.
        filter(group => group.kibokan.category_name === category.name);

      return { category, groups };
    });

    const panels = categorizedGroupsList.map(({ category, groups }) => {
      return (
        <CategorizedGroupsPanel category={category} groups={groups} />
      );
    });

    return panels;
  }
}
