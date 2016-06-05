#!/bin/sh
# Check that the basefolder of the environment is correctly set
if [ ! -d "$BASEFOLDER" ]; then
    echo "Please define the BASEFOLDER variable. It should point to the parent folder of your Appengine and Golang environment."
    exit 1
fi

# Check that the launcher is used from the root of the project
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ ! -w "$DIR"/.vscode/settings.json ]; then
    echo "This launcher should be launched form the vscode workspace folder (root of your project)."
    exit 1
fi

GOAPPENGINE=$BASEFOLDER/go_appengine
GOROOT=$GOAPPENGINE/goroot
GOPATH=$BASEFOLDER/go:$GOROOT
PATH=$GOAPPENGINE:$GOPATH/bin:$PATH

sed -i 's|"go.gopath".*".*"|"go.gopath": "'"$GOPATH"'"|g' .vscode/settings.json
sed -i 's|"go.goroot".*".*"|"go.goroot": "'"$GOROOT"'"|g' .vscode/settings.json

visual-studio-code ./ &

