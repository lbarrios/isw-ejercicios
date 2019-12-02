class LogInInputComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      clientId: "",
      password: ""
    }
  }

  handleChange(event,keyToChange) {
    const o = {}
    o[keyToChange] = event.target.value
    this.setState(o)
  }

  handleSend() {
    const {
      router,
    } = this.props

    const {
      clientId,
      password
    } = this.state

    getLocalAsJson(`createCart?clientId=${clientId}&password=${password}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/catalog", { clientId, password ,cartId: json })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
        router.navigate("/logInError", {})
      });
  }

  render() {
    const {
      clientId,
      password
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Ingrese usuario y contraseña:
          </Typography>
        <TextField className={classes.textField} value={clientId} label="Username" onChange={(ev)=>this.handleChange(ev,"clientId")}/>
        <TextField className={classes.textField} type="password" value={password} label="Password" onChange={(ev)=>this.handleChange(ev,"password")}/>
        

        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Create cart
      </Button>
      </div>
    )
  }
}

// Add style
const LogInInputView = withStyles(styles, {
  withTheme: true
})(LogInInputComponent)
