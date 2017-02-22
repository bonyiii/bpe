import { PropTypes } from 'react'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'

import BpeStates from './bpe_states.jsx'
import Vehicles from './vehicles.jsx'
import App from './app.jsx'

const emptyObject = (obj) => (
  Object.keys(obj).length === 0 && obj.constructor === Object
)

const Root = ({ store }) => {
  // Try implementing: https://github.com/mxstbr/login-flow
  const checkAuth = (nextState, replaceState) => {
    const { currentUser } = store.getState()

    if (emptyObject(currentUser)) {
      console.log("Not signed in, yet")
      replaceState(null, "/")
    }
    //else {
    // replaceState(null, nextState.location.pathname)
    //}
  }

return(
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path="/" component={App} >
        <Route onEnter={checkAuth}>
          <Route path='/states' component={BpeStates} />
          <Route path='/vehicles' component={Vehicles} />
        </Route>
      </Route>
    </Router>
  </Provider>
  )
}
Root.propTypes ={
  store: PropTypes.object.isRequired
}

export default Root
