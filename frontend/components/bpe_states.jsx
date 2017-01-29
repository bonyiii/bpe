import { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router'

import * as actions from '../actions'
import { getBpeStates, getCurrentUser } from '../reducers'
import BpeState from './bpe_state.jsx'
import AddBpeState from './add_bpe_state.jsx'

class BpeStates extends Component {
  componentDidMount() {
    this.fetchData()
  }

  fetchData() {
    const { fetchBpeStates, fetchCurrentUser, currentUser } = this.props
    if (!currentUser || currentUser != {}) {
      fetchCurrentUser().then(response => console.log(response, "fetch user done!"))
    }
    fetchBpeStates().then(response => console.log(response, "fetchBpeStates done!"))
  }

  render() {
    const { bpeStates } = this.props
    const currentUser = this.props.currentUser || {}
    //console.log(bpeStates)
    return(
      <div>
        {currentUser.is_admin && <AddBpeState {...this.props} />}
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>From State</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {bpeStates.map( state =>
              <BpeState
                  key={state.id}
                  bpeStates={bpeStates}
                  currentUser={currentUser}
                  {...state}
              />
             )}
          </tbody>
        </table>
      </div>
    )
  }
}

const mapStateToProps = (state, { params }) => {
  return {
    bpeStates: getBpeStates(state),
    currentUser: getCurrentUser(state)
  }
}
BpeStates = withRouter(connect(
  mapStateToProps,
  actions
)(BpeStates))

export default BpeStates
