var paths = {
	  "/": {content: component =>component.contentForRoot()},
	  "/logInError": {content: component =>component.contentForLogInError()},
	  "/catalog": {content: component =>component.contentForCatalog()},
	  "/bookDetails": {content: component =>component.contentForBook()},
	  "/cart": {content: component =>component.contentForCart()},
	  "/ticket": {content: component =>component.contentForTicket()},
	  "/history": {content: component =>component.contentForHistory()},
};
function getPath(path){
  return paths[path];
}