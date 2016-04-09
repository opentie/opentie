import React, { Component } from 'react';

export default class Breadcrumb extends Component {
  render (){
    return (
      <ol className="breadcrumb breadcrumb-toplevel">
        <li><a href="#">企画</a></li>
        <li className="active">新規登録</li>
      </ol>
    );
  }
}
