# iOS Test Automation

This repository will include experiments in test automation for iOS.

## Navigation

The Navigation project attempts to test storyboards by navigating around the
app using segues. The challenge is that popping to the root view controller
and performing segues is done with animations which do not provide a
completion block so timing is currently done with a delay which could be
off and cause tests to fail. There is code in place to try out techniques
with CATransaction and UIView animations with completion blocks but
those attempts were not reliable.

# License

MIT

# Credits

Brennan Stehling (@smallsharptools)
