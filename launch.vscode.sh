#!/bin/sh

#in order to support several visual-studio-code installation and alias, if $VSCODEBIN define no overwrite it.
if [ "$VSCODEBIN" = "" ]
then
   VSCODEBIN="code"
fi

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
# Check that the appengine is there as expected
if [ ! -d "$GOAPPENGINE" ]; then
    echo "Can't find the 'go_appengine' folder under the BASEFOLDER."
    exit 1
fi

# Check that the GOPATH is there as expected
if [ ! -d "$BASEFOLDER"/go/src ]; then
    echo "Can't find the 'src' folder under the GOPATH."
    exit 1
fi

GOPATH=$BASEFOLDER/go:$GOROOT
PATH=$GOAPPENGINE:$GOPATH/bin:$PATH

sed -ie 's|"go.gopath".*".*"|"go.gopath": "'"$GOPATH"'"|g' .vscode/settings.json
sed -ie 's|"go.goroot".*".*"|"go.goroot": "'"$GOROOT"'"|g' .vscode/settings.json

eval $VSCODEBIN ./ &
