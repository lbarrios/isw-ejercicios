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

  contentForTicket(){
    return this.iconButton("close",() => this.props.router.navigate("/", { }))
  }

  contentForCatalog(){
    return (<div>
    {this.iconButton("close",() => this.props.router.navigate("/", { }))}
    {this.iconButton("assignment",() => this.props.router.navigate("/history", { }))}
    {this.iconButton("shopping_cart",() => this.props.router.navigate("/cart", { }))}
    </div>)
  }

  contentForBook(){
    return (<div>
    {this.iconButton("close",() => this.props.router.navigate("/", { }))}
    {this.iconButton("arrow_back",() => this.props.router.navigate("/catalog", { }))}
    {this.iconButton("assignment",() => this.props.router.navigate("/history", { }))}
    {this.iconButton("shopping_cart",() => this.props.router.navigate("/cart", { }))}
    </div>)
  }

  contentForCart(){
    return (<div>
    {this.iconButton("close",() => this.props.router.navigate("/", { }))}
    {this.iconButton("arrow_back",() => this.props.router.navigate("/catalog", { }))}
    {this.iconButton("assignment",() => this.props.router.navigate("/history", { }))}
    </div>)
  }

  contentForHistory(){
    return (<div>
    {this.iconButton("close",() => this.props.router.navigate("/", { }))}
    {this.iconButton("arrow_back",() => this.props.router.navigate("/catalog", { }))}
    {this.iconButton("shopping_cart",() => this.props.router.navigate("/cart", { }))}
    </div>)
  }

  render() {
    const {
      router,
      title,
      classes,
    } = this.props

    const current_path = router.current()
    let content = current_path.content(this)

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
