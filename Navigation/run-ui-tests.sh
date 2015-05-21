#!/bin/sh

# build the app
xcodebuild -project Navigation.xcodeproj -target Navigation -configuration Debug

# Note: The docs indicate that -w is option if the Simulator is being used which is
# no longer accurate for Xcode 6 and later. Get a list of all known devices with the
# following command.
#
# instruments -s devices

# get the path to the most recently built app
APP=`ls -1 -d -t ~/Library/Developer/Xcode/DerivedData/*/Build/Products/*-iphonesimulator/Navigation.app | head -n 1`

TEMPLATE=./UIAutomation.tracetemplate
SCRIPT=./UIAutomation.js
RESULTS_PATH=./tests
TRACES_PATH=./test-traces

# iPhone 6 (8.3 Simulator)
DEVICE_ID=`instruments -s devices |grep -i "iphone 6 (" | sed 's/.*\[//' | sed 's/\]//'`

# add -v to make output verbose
instruments -w $DEVICE_ID -D $TRACES_PATH -t $TEMPLATE $APP -e UIASCRIPT $SCRIPT -e UIARESULTSPATH $RESULTS_PATH
