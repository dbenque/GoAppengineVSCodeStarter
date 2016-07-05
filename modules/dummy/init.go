package dummy

import "net/http"
import "GoAppengineVSCodeStarter/pkg/dummy"

// This file should only define the handler to be used for each pattern of the module
// Ideally it will be you only go source file inside the module folder
// Reason being that you will not be able to use the debugger on files under the module folder.
// Recommendation is to place all the code in any other location under GOPATH.

func init() {
	http.HandleFunc("/", dummy.Handler)
}
