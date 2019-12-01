class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: getPath("/"),
      clientId: "",
      password: "",
      cartId: "",
      currentBook: ""
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

  contentForError(){
    return (<Typography component="h1" >
          ERROR
          </Typography>)
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

  render() {
    let title = "Tus Libros"
    let content = this.state.path.content(this)
    

    /* else if (this.state.path === "/list") {//TODO cambiar
      content = (<SubstringsView
        router={router}
        substrings={this.state.substrings}
      />)
    } else if (this.state.path === "/details") {//TODO cambiar
      content = (<SubstringDetailsView
        router={router}
        selectedSubstring={this.state.selectedSubstring}
      />)
    }*/
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
