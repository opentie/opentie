import React from 'react';
import { Route } from 'react-router';
import App from './containers/app';
import DashboardPage from './containers/dashboard_page';
import GroupShowPage from './containers/group_show_page';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={DashboardPage} />
    <Route path="groups/:group_id" component={GroupShowPage} />
  </Route>
);
