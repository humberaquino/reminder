import ReminderDash from './components/ReminderDash'
import ReminderList from './components/ReminderList'
import ReminderCreate from './components/ReminderCreate'
import React from 'react'
import ReactDOM from 'react-dom'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
  } from 'react-router-dom'

import { createClient, Provider } from 'urql';

const client = createClient({
  url: 'http://localhost:4000/gql',
});

const App = () => (
  <Provider value={client}>
    <Router>
      <div>
        <ul className="flex">
        <li className="mr-6">
            <Link to="/app" className="text-blue-500 hover:text-blue-800" >Groups</Link>
        </li>
        <li className="mr-6">
            <Link to="/app/reminders" className="text-blue-500 hover:text-blue-800" >Reminders</Link>
        </li>
        <li className="mr-6">
            <Link to="/app/reminders/create" className="text-blue-500 hover:text-blue-800" >New reminder</Link>
        </li>
        </ul>

        <hr/>

        <Switch>
          <Route exact path="/app" component={ReminderDash}/>
          <Route exact path="/app/reminders" component={ReminderList}/>
          <Route exact path="/app/reminders/create" component={ReminderCreate}/>
        </Switch>
      </div>
    </Router>

  </Provider>
);

// define({ 'x-app': App  })

ReactDOM.render(<App />, document.getElementById('root'));