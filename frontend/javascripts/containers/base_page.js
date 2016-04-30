import React, { Component } from 'react';
import Loader from 'react-loader';
import { EventEmitter } from 'events';

export default class BasePage extends Component {
  constructor(props) {
    super(props);
    this.state = { isLoaded: false, hasError: false };
    this.emitter = new EventEmitter();

    this.doFetch = this.doFetch.bind(this);
    this.doingFetch = this.doingFetch.bind(this);
    this.doneFetch = this.doneFetch.bind(this);
    this.failedFetch = this.failedFetch.bind(this);

    this.emitter.on('do-fetch', this.doFetch);
    this.emitter.on('doing-fetch', this.doingFetch);
    this.emitter.on('done-fetch', this.doneFetch);
    this.emitter.on('failed-fetch', this.failedFetch);
  }

  componentWillMount() {
    this.emitter.emit('do-fetch');
  }

  componentWillUnmount() {
    this.emitter.removeAllListeners();
  }

  doFetch() {
    this.emitter.emit('doing-fetch');
    const onAbort = new Promise((resolve, reject) => {
      this.emitter.once('do-fetch', reject.bind('aborted'));
    });

    Promise.race([ onAbort, this.fetch() ]).
    then(payload => {
      this.setState({ payload });
      this.emitter.emit('done-fetch');
    }).
    catch(error => {
      this.setState({ error });
      this.emitter.emit('failed-fetch');
    });
  }

  doingFetch() {
    this.setState({ hasError: false, isLoaded: false });
  }

  doneFetch() {
    this.setState({ hasError: false, isLoaded: true });
  }

  failedFetch() {
    this.setState({ hasError: true, isLoaded: false });
  }

  render() {
    const { isLoaded, hasError } = this.state;

    return (
      <div>
        {
          hasError && (
            <div className="bs-callout bs-callout-danger">
              <h4>おやおや、何かがおかしいみたいです。</h4>
              <p>{this.state.error.toString()}</p>
              <p>このエラーが常に表示される場合は学園祭実行委員会までご連絡ください。</p>
            </div>
          )
        }
        {
          !hasError && (
            <Loader loaded={isLoaded}>
              {isLoaded && this.renderContent()}
            </Loader>
          )
        }
      </div>
    );
  }
}
