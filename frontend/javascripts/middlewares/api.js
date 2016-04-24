import { Schema, arrayOf, normalize } from 'normalizr';
import { camelizeKeys } from 'humps';
import 'isomorphic-fetch';
import parseLinkHeader from 'parse-link-header';
import url from 'url';

const accountSchema = new Schema('accounts');
const divisionSchema = new Schema('divisions');
const groupSchema = new Schema('groups');
const topicSchema = new Schema('topics');
const groupTopicSchema = new Schema('groupTopics');

accountSchema.define({
  divisions: arrayOf(divisionSchema),
});

export const Schemata = {
  Account: accountSchema,
  AccountList: arrayOf(accountSchema),
  Division: divisionSchema,
  DivisionList: arrayOf(divisionSchema),
  Group: groupSchema,
  GroupList: arrayOf(groupSchema),
  Topic: topicSchema,
  TopicList: arrayOf(topicSchema),
  GroupTopic: groupTopicSchema,
  GroupTopicList: arrayOf(groupTopicSchema),
};

const API_ROOT = '/api/v1/';

export const CALL_API = Symbol('CALL_API');

function has(obj, prop) {
  return Object.hasOwnProperty.call(obj, prop);
}

function getPagination(response) {
  const parsedLinkHeader = parseLinkHeader(
    response.headers.get('link'));

  const obj = {};
  for (const key of Object.keys(parsedLinkHeader)) {
    obj[key] = parsedLinkHeader[key].url;
  }

  return obj;
}

function callApi(endpoint, schema) {
  const fullUrl = url.resolve(API_ROOT, endpoint);

  return fetch(fullUrl, { credentials: 'same-origin' }).
    then(response =>
      response.json().then(json => ({ json, response }))
    ).
    then(({ json, response }) => {
      if (!response.ok) {
        return Promise.reject(json);
      }

      const camelizedJson = camelizeKeys(json);
      //const pagination = getPagination(response);

      return Object.assign({},
        normalize(camelizedJson, schema),
        //{ pagination }
      );
    });
}

export default () => next => action => {
  if (!has(action, CALL_API)) {
    return next(action);
  }

  const { endpoint, schema, types } = action[CALL_API];
  const [ requestType, successType, failureType ] = types;

  function actionWith(data) {
    const finalAction = Object.assign({}, action, data);
    delete finalAction[CALL_API];
    return finalAction;
  }


  next(actionWith({ type: requestType }));

  return callApi(endpoint, schema).then(
    response => next(actionWith({
      response,
      type: successType,
    })),
    error => next(actionWith({
      error,
      type: failureType,
    }))
  );
};
