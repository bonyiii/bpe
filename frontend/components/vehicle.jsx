const Vehicle = ({
  name,
  state,
  onToNextStateClick
}) => (
  <tr>
    <td>
      {name}
    </td>
    <td>
      {state.name}
    </td>
    <td>
      <button
          onClick={onToNextStateClick}
      >
        Next state
      </button>
    </td>
  </tr>
)

export default Vehicle
