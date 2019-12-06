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
        console.log('Ok, going to catalog');
        router.navigate("/catalog", { clientId, password ,cartId: json });
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
      <Container component="main" maxWidth="xs">
      <div className="login-page" style={loginPage}>
        <Typography component="h1" variant="h5">
          Ingrese usuario y contraseña:
        </Typography>
        <form action="#catalog" className="form" style={form} onSubmit={(ev)=>this.handleSend(ev)}>
          <TextField 
            variant="outlined" 
            className={classes.textField}
            margin="normal"
            required
            fullWidth
            value={clientId}
            id="clientId"
            label="Usuario"
            //autoComplete="clientId"
            onChange={(ev)=>this.handleChange(ev,"clientId")}
            autoFocus
          />
          <TextField 
            variant="outlined" 
            className={classes.textField}
            margin="normal"
            required
            fullWidth
            id="password"
            type="password"
            value={password}
            label="Password"
            //autoComplete="password"
            onChange={(ev)=>this.handleChange(ev,"password")}/>
          <Button 
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            onClick={(ev)=>this.handleSend(ev)}>Crear Carrito
          </Button>
        </form>
      </div>
      </Container>
    )
  }
}

const loginPage = {
    marginTop: theme.spacing(8),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
};

const form = {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
};

// Add style
const LogInInputView = withStyles(styles, {
  withTheme: true
})(LogInInputComponent);