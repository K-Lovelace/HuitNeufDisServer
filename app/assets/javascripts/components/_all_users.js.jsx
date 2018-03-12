class AllUsers extends React.Component {
  componentDidMount() {
    console.log('Component mounted');
    $.getJSON('/users.json', (response) => { this.setState({users: response}) } )
  }

  constructor(props) {
    super(props)
    this.state = {
      users: []
    }
  }

  render() {
    var users= this.state.users.map((user) => {
      return (
        <User key={user.id} user={user} loadDetails={this.props.loadDetails}/>
      )
    });

    return(
      <div>
        {users}
      </div>
    )
  }
}
