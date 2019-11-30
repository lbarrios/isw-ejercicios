class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  iconButton(icon,onclick){
    const classes = this.props.classes
    return (<IconButton
              edge="start"
              className={classes.menuButton}
              color="inherit"
              onClick={onclick}
            >
              <Icon>{icon}</Icon>
            </IconButton>)
  }

  contentForRoot() {
    return ""
  }

  contentForLogInError(){
    return this.iconButton("home",() => this.props.router.navigate("/", { }))
  }

  contentForError(){
    return this.iconButton("home",() => this.props.router.navigate("/", { }))
  }

  contentForCatalog(){
    
  }

  render() {
    const {
      router,
      title,
      classes,
    } = this.props

    const current_path = router.current()
    let content = current_path.content(this)

    /*if (current_path === "/") {
      icon = "home"
      onclick = () => {}
    } else if (current_path === "/list") {
      icon = "home"
      onclick = () => router.navigate("/", {
        substrings: [],
        selectedSubstring: "",
      })
    } else if (current_path === "/details") {
      icon = "keyboard_arrow_left"
      onclick = () => router.navigate("/list", {
        selectedSubstring: "",
      })
    } else {
      console.error("Not a valid current path!")
    }*/

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
          {content}
          <Typography variant="h6" className={classes.title}>
              {title}
          </Typography>
          </Toolbar>
        </AppBar>
      </div>
    )
  }

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
