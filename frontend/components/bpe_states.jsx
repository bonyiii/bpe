import { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router'
import * as actions from '../actions'
import { getBpeStates } from '../reducers'
import State from './state.jsx'

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
    // console.log(bpeStates)
    return(
      <ul>
      {bpeStates.map( state =>
        <State
            key={state.id}
            {...state}
        />
      )}
    </ul>
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
