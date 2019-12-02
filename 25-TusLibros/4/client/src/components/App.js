class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: getPath("/"),
      clientId: "",
      password: "",
      cartId: "",
      currentBook: "",
      ticket: ""
    };
  }

  get router() {
    return {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: getPath(path) })
      }
    }
  }

  contentForRoot() {
    return (<LogInInputView
        router={this.router}
      />)
  }

  contentForLogInError(){
    return (<Typography component="h1" >
          Usuario o contraseña inválida.
          </Typography>)
  }

  contentForTicket(){
    
    return (<div>
      <Typography component="h1" >
          Purchase succesful!
          </Typography>
      <TextField value={this.state.ticket}
        InputProps={{
            readOnly: true,
          }}/>
    </div>)
  }

  contentForCatalog(){
    const cartId = this.state.cartId
    return (<CatalogView
        router={this.router}
        cartId={cartId}
      />)
  }

  contentForBook(){
    const {
      cartId,
      currentBook
    } = this.state
    return (<BookView
        cartId={cartId}
        currentBook={currentBook}
        />)
  }

  contentForCart(){
    const {
      cartId,
    } = this.state
    return (<CartView
        cartId={cartId}
        router={this.router}
        />)
  }

  contentForHistory(){
    const {
      clientId,
      password
    } = this.state
    return (<HistoryView
      clientId={clientId}
      password={password}
      />)
  }

  render() {
    let title = "Tus Libros"
    let content = this.state.path.content(this)
    

    
    return (
      <div>
        <MyToolBar
          title={title}
          router={this.router}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
