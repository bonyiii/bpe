import { PropTypes } from 'react'
import { Provider } from 'react-redux'
import { Router, Route, browserHistory } from 'react-router'
import BpeStates from './bpe_states.jsx'

const Root = ({ store }) => (
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path='(/)(:filter)' component={BpeStates} />
    </Router>
  </Provider>
)
Root.propTypes ={
  store: PropTypes.object.isRequired
}

export default Root
