import { Link } from 'react-router'

const ACTIVE = { color: 'red' }

const App = ({
  children
}) => (
  <div>
    <nav>
      <Link to='/states' activeStyle={ACTIVE}>States</Link>
      <Link to='/vehicles' activeStyle={ACTIVE}> Vehicles </Link>
    </nav>

    {children}
  </div>
)

export default App
