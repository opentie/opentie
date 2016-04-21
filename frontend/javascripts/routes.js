import React from 'react';
import { Route, IndexRoute } from 'react-router';
import ToplevelNavbar from './components/toplevel_navbar.js';
import GroupsNavbar from './components/groups_navbar.js';
import Containers from './containers';

export default (
  <Route path="/" component={Containers.App}>
    <Route components={{ navbar: ToplevelNavbar, main: Containers.ToplevelLayout }}>
      <IndexRoute component={Containers.DashboardPage} />
      <Route path="account/new" component={Containers.AccountsNewPage} />
    </Route>
    <Route path="groups" components={{ navbar: GroupsNavbar, main: Containers.GroupLayout }}>
      <Route path="new" component={Containers.GroupsNewPage} />
      <Route path=":group_id">
        <IndexRoute component={Containers.GroupsShowPage} />
        <Route path="sub_schemata/" component={Containers.Groups.SubSchemataIndexPage} />
        <Route path="sub_schemata/:sub_schemata_id" component={Containers.Groups.SubSchemataShowPage} />
        <Route path="message" component={Containers.Groups.MessageLayout}>
          <Route path="topics" component={Containers.Groups.Message.TopicsIndexPage} />
        </Route>
      </Route>
    </Route>
  </Route>
);
