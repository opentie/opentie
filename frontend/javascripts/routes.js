import React from 'react';
import { Route } from 'react-router';
import App from './containers/app';
import DashboardPage from './containers/dashboard_page';

export default (
  <Route component={App}>
    <Route path="/" component={DashboardPage} />
  </Route>
);
