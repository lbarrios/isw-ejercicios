function getPath(path){
  const paths = {}
  paths["/"] = {content: component =>component.contentForRoot()}
  paths["/logInError"] = {content: component =>component.contentForLogInError()}
  paths["/error"] = {content: component =>component.contentForError()}
  paths["/catalog"] = {content: component =>component.contentForCatalog()}
  return paths[path]
}