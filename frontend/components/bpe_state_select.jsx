import { connect } from 'react-redux'

let BpeStateSelect = ({
  bpeStates,
  selected
}) => {
  let select

  return(
    <select
        ref={ node => { select = node } }
        defaultValue={selected}
    >
      <option></option>
      {
        bpeStates.map(
          state =>
            <option
                key={state.id}
                value={state.id}
            >
              {state.name}
            </option>
        )
      }
    </select>
  )
}

BpeStateSelect = connect()(BpeStateSelect)
export default BpeStateSelect
