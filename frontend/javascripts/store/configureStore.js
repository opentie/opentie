import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import createLogger from 'redux-logger';
import rootReducer from '../reducers';
import DevTools from '../containers/dev_tools';
import api from '../middlewares/api';

export default function configureStore (initialState) {
  const store = createStore(
    rootReducer,
    initialState,
    compose(
      //DevTools.instrument(),
      applyMiddleware(
        thunk,
        api,
        createLogger()
      )
    )
  );

  return store;
}
