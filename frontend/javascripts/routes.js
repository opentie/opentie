import React from 'react';
import { Route, IndexRoute } from 'react-router';
import C from './containers';

export default (
  <Route path="/" component={C.App}>
    <IndexRoute component={C.DashboardPage} />
    <Route path="accounts/new" component={C.AccountsNewPage} />
    <Route path="groups/new" component={C.GroupsNewPage} />
    <Route path="groups/:group_id" component={C.GroupsShowPage} />
  </Route>
);
