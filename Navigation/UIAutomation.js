/* global UIALogger */
/* global UIATarget */

// Documentation
// https://developer.apple.com/library/ios/documentation/DeveloperTools/Reference/UIAutomationRef/index.html
// https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIATargetClassReference/index.html

#import "./UIAutomation-One.js"
#import "./UIAutomation-Two.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var navBar = app.navigationBar();

UIALogger.logStart("Testing");

testOne(target, app, navBar);

testTwo(target, app, navBar);

if (navBar.name() == "Home") {
    UIALogger.logPass("Home is title");
} else {
    UIALogger.logFail("Wrong title for Home View Controller");
}

//target.deactivateAppForDuration(2);

//target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT); 
//target.delay(2);

//target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT); 
//target.delay(2);
