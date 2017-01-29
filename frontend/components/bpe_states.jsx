import { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router'

import * as actions from '../actions'
import { getBpeStates } from '../reducers'
import BpeState from './bpe_state.jsx'
import AddBpeState from './add_bpe_state.jsx'

class BpeStates extends Component {
  componentDidMount() {
    this.fetchData()
  }

  componentDidUpdate(prevProps) {
    //    this.fetchData()
  }

  fetchData() {
    const { fetchBpeStates } = this.props
    fetchBpeStates().then(response => console.log(response, "fetchBpeStates done!"))
  }

  render() {
    const { bpeStates } = this.props
    //console.log(bpeStates)
    return(
      <div>
        <AddBpeState {...this.props} />
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>From State</th>
            </tr>
          </thead>
          <tbody>
            {bpeStates.map( state =>
              <BpeState
                  key={state.id}
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
    bpeStates: getBpeStates(state.bpeStates)
  }
}

BpeStates = withRouter(connect(
  mapStateToProps,
  actions
)(BpeStates))

export default BpeStates
