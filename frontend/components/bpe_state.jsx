const BpeState = ({
  name,
  from_state
}) => (
  <tr>
    <td>
      {name}
    </td>
    <td>
      {' <- '}
      {!!from_state && from_state.name}
    </td>
  </tr>
)

export default BpeState
