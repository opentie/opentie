import React from 'react';
import { Route, IndexRoute, Redirect } from 'react-router';
import ToplevelNavbar from './components/toplevel_navbar.js';
import GroupsNavbar from './components/groups_navbar.js';
import GuestNavbar from './components/guest_navbar.js';
import Containers from './containers';

export default (
  <Route path="/">
    <Redirect from="/register" to="/" />
    <Route component={Containers.App}>
      <Route components={{ navbar: GuestNavbar, main: Containers.ToplevelLayout }}>
        <IndexRoute component={Containers.WelcomePage} />
        <Route path="account/new" component={Containers.AccountsNewPage} />
        <Route path="account/email_sent" component={Containers.AccountsEmailSentPage} />
        <Route path="account/email_confirm" component={Containers.AccountsEmailConfirmPage} />
      </Route>
    </Route>
    <Route component={Containers.SigninRequired}>
      <Route component={Containers.App}>
        <Route components={{ navbar: ToplevelNavbar, main: Containers.ToplevelLayout }}>
          <Route path="dashboard" component={Containers.DashboardPage} />
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
    </Route>
  </Route>
);
