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
      <div className="row">
        <div className="column medium-6">
          { has_next_state &&
            <button onClick={onToNextStateClick} className="button">Next state</button>
          }
        </div>
        <div className="column medium-6">
          { currentUser.is_admin
            && <button onClick={deleteVehicle} className="button alert">Delete</button>
          }
        </div>
      </div>
    </td>
  </tr>
)

export default Vehicle
