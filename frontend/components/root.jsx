import { PropTypes } from 'react'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'

import BpeStates from './bpe_states.jsx'
import Vehicles from './vehicles.jsx'
import Login from './login.jsx'
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
      replaceState({
        pathname: '/login',
        state: { nextPathname: nextState.location.pathname }
      })
    }
    //else {
    // replaceState(null, nextState.location.pathname)
    //}
  }

  return(
    <Provider store={store}>
      <Router history={browserHistory}>
        <Route path="/" component={App} >
        <Route path='/states' component={BpeStates} onEnter={checkAuth} />
        <Route path='/vehicles' component={Vehicles} onEnter={checkAuth} />
        <Route path='/login' component={Login} />
      </Route>
      </Router>
    </Provider>
  )
}
Root.propTypes ={
  store: PropTypes.object.isRequired
}

export default Root
