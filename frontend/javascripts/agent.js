import { EventEmitter } from 'events';
import url from 'url';

const UNAUTHORIZED = 401;

class Agent extends EventEmitter {
  constructor(baseUrl) {
    super();

    this.baseUrl = baseUrl;
    this.isSignedin = true;
  }

  set isSignedin(state) {
    if (this._isSignedin === state) {
      return;
    }

    this._isSignedin = state;
    this.emit('change');
  }
  get isSignedin() {
    return this._isSignedin;
  }

  request(method, endpoint, body = null) {
    const options = {
      method,
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'xhr',
      },
      credentials: 'same-origin',
    };
    if (body) {
      options.body = JSON.stringify(body);
    }
    return fetch(url.resolve(this.baseUrl, endpoint), options).then(res => {
      if (res.status === UNAUTHORIZED) {
        this.isSignedin = false;
        return new Promise((resolve) => {
          this.once('change', resolve);
        }).then(() => this.request(method, endpoint, body));
      }
      if (!res.ok) {
        const error = new Error(res.statusText);
        error.response = res;
        throw error;
      }
      this.isSignedin = true;
      return res.json();
    });
  }
}

export default new Agent('/api/v1/');
