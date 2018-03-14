const { Card, CardBody, CardTitle, CardSubtitle, Button } = Reactstrap;

class Box extends React.Component {

  render() {
    return (
      <Card body color={this.props.box.stock > 0 ? "warning" : "danger"}>
        <CardTitle>{this.props.box.name}</CardTitle>
        <CardSubtitle>Stock restant: {this.props.box.stock}</CardSubtitle>
      </Card>
    )
  }

}