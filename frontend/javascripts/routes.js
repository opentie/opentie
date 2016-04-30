import React from 'react';
import { Route, IndexRoute } from 'react-router';
import ToplevelNavbar from './components/toplevel_navbar.js';
import GroupsNavbar from './components/groups_navbar.js';
import Containers from './containers';

export default (
  <Route path="/" component={Containers.App}>
    <Route components={{ navbar: ToplevelNavbar, main: Containers.ToplevelLayout }}>
      <Route component={Containers.SigninRequired} >
        <IndexRoute component={Containers.DashboardPage} />
      </Route>
      <Route path="dashboard" component={Containers.DashboardPage} />
      <Route path="account/new" component={Containers.AccountsNewPage} />
      <Route path="categories">
        <Route path="new" />
        <Route path=":category_name">
          <Route path="groups">
            <IndexRoute />
            <Route path="new" component={Containers.Categories.GroupsNewPage} />
          </Route>
        </Route>
      </Route>
    </Route>
    <Route path="groups" components={{ navbar: GroupsNavbar, main: Containers.GroupLayout }}>
      <Route path="new" component={Containers.GroupsNewPage} />
      <Route path=":group_id">
        <IndexRoute component={Containers.GroupsShowPage} />
        <Route path="schemata/" component={Containers.Groups.SchemataIndexPage} />
        <Route path="schemata/:schema_id" component={Containers.Groups.SchemataShowPage} />
        <Route path="message" component={Containers.Groups.MessageLayout}>
          <Route path="topics" component={Containers.Groups.Message.TopicsIndexPage} />
        </Route>
      </Route>
    </Route>
  </Route>
);
