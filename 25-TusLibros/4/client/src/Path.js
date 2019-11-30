function getPath(path){
  const paths = {}
  paths["/"] = {content: component =>component.contentForRoot()}
  paths["/logInError"] = {content: component =>component.contentForLogInError()}
  paths["/error"] = {content: component =>component.contentForError()}
  return paths[path]
}