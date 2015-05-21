
function testOne(target, app, navBar) {
    app.mainWindow().buttons()["One"].tap();
    target.delay(0.5);
    
    if (navBar.name() == "One") {
        UIALogger.logPass("One is title");
    } else {
        UIALogger.logFail("Wrong title for One View Controller");
    }
    
    app.mainWindow().buttons()["Go Home"].tap();
    target.delay(0.5);
}
