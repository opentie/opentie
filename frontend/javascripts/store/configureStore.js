import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import createLogger from 'redux-logger';
import rootReducer from '../reducers';
import DevTools from '../containers/dev_tools';

export default function configureStore (initialState) {
  const store = createStore(
    rootReducer,
    initialState,
    compose(
      DevTools.instrument(),
      applyMiddleware(
        thunk
      )
    )
  );

  return store;
}
