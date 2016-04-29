export const DIVISIONS_REQUEST = 'DIVISIONS_REQUEST';
export const DIVISIONS_SUCCESS = 'DIVISIONS_SUCCESS';
export const DIVISIONS_FAILURE = 'DIVISIONS_FAILURE';

export const ACCOUNT_REQUEST = 'ACCOUNT_REQUEST';
export const ACCOUNT_SUCCESS = 'ACCOUNT_SUCCESS';
export const ACCOUNT_FAILURE = 'ACCOUNT_FAILURE';

function fetchAccount() {
  console.log('OK');
  return {
    [CALL_API]: {
      types: [ ACCOUNT_REQUEST, ACCOUNT_SUCCESS, ACCOUNT_FAILURE ],
      endpoint: 'account',
      schema: Schemata.Account,
    }
  };
}

export function loadAccount() {
  return (dispatch, getState) => {
    const dashboard = getState().entities.dashboard;
    if (dashboard && dashboard.divisions) {
      return null;
    }

    return dispatch(fetchAccount());
  };
}
