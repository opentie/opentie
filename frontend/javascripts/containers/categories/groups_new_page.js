import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { browserHistory } from 'react-router';

import Category from 'kibokan/category';

import Form from '../../components/kibokan/form';

export default class GroupsNewPage extends Component {
  render() {
    const category = new Category('企画');
    const rootSchema = category.createSchema({
      name: '企画基本情報',
      description: 'このフォームは一般企画・ステージ企画共通の事項です。',
      fields: [
        category.createField('TextField', {
          name: '企画名',
          description: '企画名を入力してください',
          isRequired: true,
          validators: [
            category.createValidator('MaxlengthValidator', 20)
          ]
        }),
        category.createField('TextField', {
          name: '企画名ふりがな',
          description: '企画名のふりがなを入力してください',
          isRequired: true,
          validators: []
        }),
        category.createField('TextField', {
          name: '企画団体名',
          description: '企画を主催する団体名を入力してください',
          isRequired: true,
          validators: []
        }),
        category.createField('TextField', {
          name: '企画団体名ふりがな',
          description: '企画団体名のふりがなを入力してください',
          isRequired: true,
          validators: []
        }),
        category.createField('ParagraphField', {
          name: '企画概要',
          description: '企画の概要を入力してください',
          isRequired: true,
          validators: []
        }),
      ]
    });
    category.schemata = [rootSchema];
    category.rootSchemaName = '企画基本情報';

    return (
      <div>
        <h1>企画登録</h1>
        <Form schema={category.rootSchema} />
      </div>
    );
  }
}
