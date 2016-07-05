package dummy

import (
	"fmt"
	"net/http"

	"appengine"
)

func init() {
	http.HandleFunc("/", handler)
}

func handler(w http.ResponseWriter, r *http.Request) {
	context := appengine.NewContext(r)
	moduleName := appengine.ModuleName(context)
	fmt.Fprintf(w, "Hello, I am Module %s.\n", moduleName)
}
