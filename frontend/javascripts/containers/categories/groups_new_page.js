import React, { Component, PropTypes } from 'react';

import Category from 'kibokan/category';

import Wizard from '../../components/kibokan/wizard';

export default class GroupsNewPage extends Component {
  constructor() {
    super();
    const category = new Category('企画');
    category.schemata = [
      category.createSchema({
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
          category.createField('RadioField', {
            name: '企画実施場所',
            description: '企画を実施する場所を選択してください。\n(希望数に応じて後ほど変更をお願いする場合があります)',
            isRequired: true,
            validators: [],
            options: [
              category.createOptionItem({
                label: '屋内(会館以外)',
                attachmentNames: ['屋内企画基本情報'],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: '会館屋内',
                attachmentNames: [],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: '屋外',
                attachmentNames: [],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: 'ステージ',
                attachmentNames: [],
                insertionFields: [],
              }),
            ]
          }),
        ]
      }),
      category.createSchema({
        name: '屋内企画基本情報',
        description: 'ほげ',
        fields: [
          category.createField('RadioField', {
            name: '希望実施エリア',
            description: null,
            isRequired: true,
            validators: [],
            options: [
              category.createOptionItem({
                label: 'エリア未確定',
                attachmentNames: [],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: '第一エリア',
                attachmentNames: [],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: '第二・第三エリア',
                attachmentNames: [],
                insertionFields: [],
              }),
              category.createOptionItem({
                label: '大芸エリア',
                attachmentNames: [],
                insertionFields: [],
              }),
            ]
          })
        ]
      })
    ];
    category.rootSchemaName = '企画基本情報';

    this.state = { category, schema: category.rootSchema };
  }

  render() {
    return (
      <Wizard title="企画登録" schema={this.state.schema} />
    );
  }
}
