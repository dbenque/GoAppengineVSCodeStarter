package dummy

import (
	"fmt"
	"net/http"

	"appengine"
)

//Handler one request handler for dummy module
func Handler(w http.ResponseWriter, r *http.Request) {
	context := appengine.NewContext(r)
	moduleName := appengine.ModuleName(context)
	fmt.Fprintf(w, "Hello, I am Module %s.\n", moduleName)
}
