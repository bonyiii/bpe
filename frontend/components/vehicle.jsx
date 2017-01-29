const Vehicle = ({
  name,
  has_next_state,
  state,
  onToNextStateClick,
  deleteVehicle,
  currentUser
}) => (
  <tr>
    <td>
      {name}
    </td>
    <td>
      {state.name}
    </td>
    <td>
      { has_next_state &&
        <button onClick={onToNextStateClick}>Next state</button>
      }
    { currentUser.is_admin ? <button onClick={deleteVehicle}>Delete</button> : '' }
    </td>
  </tr>
)

export default Vehicle
