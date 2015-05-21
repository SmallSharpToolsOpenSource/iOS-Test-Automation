
function testTwo(target, app, navBar) {
	app.mainWindow().buttons()["Two"].tap();
	target.delay(0.5);
	
	if (navBar.name() == "Two") {
	    UIALogger.logPass("Two is title");
	} else {
	    UIALogger.logFail("Wrong title for Two View Controller");
	}
	
	app.mainWindow().buttons()["Go Home"].tap();
	target.delay(0.5);
}
