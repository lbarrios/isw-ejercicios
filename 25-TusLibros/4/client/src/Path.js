function getPath(path){
  const paths = {}
  paths["/"] = {content: component =>component.contentForRoot()}
  paths["/logInError"] = {content: component =>component.contentForLogInError()}
  paths["/catalog"] = {content: component =>component.contentForCatalog()}
  paths["/bookDetails"] = {content: component =>component.contentForBook()}
  paths["/cart"] = {content: component =>component.contentForCart()}
  paths["/ticket"] = {content: component =>component.contentForTicket()}
  paths["/history"] = {content: component =>component.contentForHistory()}
  return paths[path]
}