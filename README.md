# iOS Test Automation

This repository will include experiments in test automation for iOS.

## Navigation

The Navigation project is a sample iOS app which uses storyboards and
segues to navigate to the 2 sub views. It is used to demonstrate how
test automation can work with segues and storyboards.

Automating tests for the UI with view controllers, storyboards and segues
can be a challenge because there are not completion blocked triggered when
animations for pushing and popping items on a navigation controller stack
have finished. Reliable tests can used a timed delay to give animations
plenty of time to finish which can cause a test suite to take a very long
time if there are many tests.

The solution used here is to set up a category for UIViewController which
defines a method to post a notification when a view controller appears.
Each view controller which is tested will check for the selector for this
method through the base view controller and only perform the segue when
it is defined. Now when the test runs are much faster and a larger test
suite will be able to run in much less time.

### UI Automation with Xcode and Instruments

The tool included with Xcode called Instruments allows for a range of
automation features with UI Automation. One feature is to use a JavaScript-like
language to script automated tests. The Navigation project has test scripts
which allow for UI testing to be automated and run from the command line.
See `run-ui-tests.sh` for details.

Test scripts with UI Automation allow for interacting with the UI of an app.
It may not be sufficient to test every aspect of your app. Combining tests
run in Xcode and via scripts with Instruments may be your best option.

To keep the test scripts managable they can use an `#import` directive which
is not a standard JavaScript language feature. In this sample projects there
are two external scripts which are imported which define a function which
take the necessary variables needed to run their tests. This way tests can
be isolated and a single script file does not get so big it becomes 
cumbersome to maintain.

For a much more complex application it would be helpful to script various
workflows as separate test scripts such as logging in, posting content,
updating user settings or commenting on a post.

* [UI Automation Reference](https://developer.apple.com/library/ios/documentation/DeveloperTools/Reference/UIAutomationRef/index.html)
* [UIATarget](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIATargetClassReference/index.html)
* [UIAApplication](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIAApplicationClassReference/index.html)
* [UIANavigationBar](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIANavigationBarClassReference/index.html)
* [UIALogger Reference](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIALoggerClassReference/index.html)

# License

MIT

# Credits

Brennan Stehling (@smallsharptools)
