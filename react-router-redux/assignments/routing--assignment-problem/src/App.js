import React, { Component } from 'react';
import { BrowserRouter, Route, Switch, NavLink, Redirect } from 'react-router-dom'

import Courses from './containers/Courses/Courses';
import Users from './containers/Users/Users';

class App extends Component {
  render () {
    return (
      <div className="App">
        <ol style={{textAlign: 'left'}}>
          <li>[Done] Add Routes to load "Users" and "Courses" on different pages (by entering a URL, without Links)</li>
          <li>[Done] Add a simple navigation with two links => One leading to "Users", one leading to "Courses"</li>
          <li>[Done] Make the courses in "Courses" clickable by adding a link and load the "Course" component in the place of "Courses" (without passing any data for now)</li>
          <li>[Done] Pass the course ID to the "Course" page and output it there</li>
          <li>[Done] Pass the course title to the "Course" page - pass it as a param or score bonus points by passing it as query params (you need to manually parse them though!)</li>
          <li>[Partyly done] Load the "Course" component as a nested component of "Courses"</li>
          <li>[Done] Add a 404 error page and render it for any unknown routes</li>
          <li>[Done] Redirect requests to /all-courses to /courses (=> Your "Courses" page)</li>
        </ol>
        <BrowserRouter>
          <div>
            <header>
              <nav>
                <ul>
                  <li>
                    <NavLink to='/courses'>Courses</NavLink>
                  </li>
                  <li>
                    <NavLink to='/users' exact>Users</NavLink>
                  </li>
                </ul>
              </nav>
            </header>
            <Switch>
              <Route path='/courses' component={Courses}></Route>
              <Route path='/users' component={Users}></Route>
              <Route render={() => <h1>404 Not Found</h1> } />
              <Redirect from='/all-courses' to='/courses'></Redirect>
            </Switch>
          </div>
          
        </BrowserRouter>
      </div>
    );
  }
}

export default App;
