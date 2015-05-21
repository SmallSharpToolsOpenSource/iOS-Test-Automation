# iOS Test Automation

This repository will include experiments in test automation for iOS.

## Navigation

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

# License

MIT

# Credits

Brennan Stehling (@smallsharptools)
