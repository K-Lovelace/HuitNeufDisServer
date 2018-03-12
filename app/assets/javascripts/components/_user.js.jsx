const { Card, CardBody, CardTitle, CardSubtitle, Button } = Reactstrap;

class User extends React.Component {

  render() {
    return (
      <Card>
        <CardBody>
          <CardTitle>{this.props.user.name}</CardTitle>
          <CardSubtitle>{this.props.user.role}</CardSubtitle>
          <Button onClick={(e) => { this.props.loadDetails(e, this.props.user) }}>Modifier</Button>
        </CardBody>
      </Card>
    )
  }

}