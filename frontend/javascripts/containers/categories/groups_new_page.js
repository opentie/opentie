import url from 'url';
import React, { Component, PropTypes } from 'react';

import { Entity } from 'kibokan';
import BasePage from '../base_page';
import agent from '../../agent';
import Form from '../../components/kibokan/form';

export default class GroupsNewPage extends BasePage {
  fetch() {
    const { category_name } = this.props.params;

    return agent.request('GET', url.format({
      pathname: 'groups/new',
      query: { category_name },
    }));
  }

  renderContent() {
    const { payload } = this.state;

    const entity = new Entity().deserialize(payload.entity);
    const form = [ ...entity.retrieveAttachableFormsMap().values() ][0];

    return (
      <Form title={`${entity.category.name}登録`} form={form} />
    );
  }
}
