import React, { Component, PropTypes } from 'react';

import Form from './form';
import Glyphicon from '../glyphicon';

export default class Wizard extends Component {
  static propTypes = {
    title: PropTypes.string.isRequired,
    schema: PropTypes.any.isRequired,
  };

  constructor(props) {
    super(props);

    this.handleOnGoNext = this.handleOnGoNext.bind(this);
    this.handleOnGoBack = this.handleOnGoBack.bind(this);

    this.state = {
      pageIndex: 0,
    };
  }

  handleOnGoNext() {
    this.setState(Object.assign({}, this.state, {
      pageIndex: this.state.pageIndex + 1
    }));
  }

  handleOnGoBack() {
    this.setState(Object.assign({}, this.state, {
      pageIndex: this.state.pageIndex - 1
    }));
  }

  render() {
    const { title, schema } = this.props;
    const attachmentSchemata = schema.retrievePossibleAttachmentSchemata();
    const pages = [schema].concat(attachmentSchemata);
    const currentSchema = pages[this.state.pageIndex];

    return (
      <div>
        <h1>{title}</h1>
        <Form schema={currentSchema} />
        <div className="clearfix">
          <button type="button" className="pull-left btn btn-primary" onClick={this.handleOnGoBack}>
            <Glyphicon glyph="menu-left" /> 戻る
          </button>
          <button type="button" className="pull-right btn btn-primary" onClick={this.handleOnGoNext}>
            次へ <Glyphicon glyph="menu-right" />
          </button>
        </div>
      </div>
    );
  }
}
