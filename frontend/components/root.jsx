import { PropTypes } from 'react'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'

import BpeStates from './bpe_states.jsx'
import Vehicles from './vehicles.jsx'
import App from './app.jsx'

const Root = ({ store }) => (
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path="/" component={App} >
        <Route path='/states' component={BpeStates} />
        <Route path='/vehicles' component={Vehicles} />
      </Route>
    </Router>
  </Provider>
)
Root.propTypes ={
  store: PropTypes.object.isRequired
}

export default Root
