#!/bin/bash

#
# I had to do that script to launch gapp with all correct environment variable
# The latest version of visual studio code I use (1.4) does not correctly set GOPATH and PATH under the task runner.  
#

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

goapp $@