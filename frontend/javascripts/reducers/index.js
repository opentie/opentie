import * as ActionTypes from '../actions';
import { combineReducers } from 'redux';
import { routerReducer as routing } from 'react-router-redux';
import merge from 'lodash/merge';

function entities(state = { accounts: {}, divisions: {} }, action) {
  if (action.response && action.response.entities) {
    return merge({}, state, action.response.entities);
  }

  return state;
}

const rootReducer = combineReducers({
  entities,
  routing,
});

export default rootReducer;
