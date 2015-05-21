//
//  NavigationTests.m
//  NavigationTests
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

#import "UIViewController+Testing.h"

#define kExpectationTimeout 5.0
#define kAnimationDuration 2.0

CG_INLINE UINavigationController *GetNavigationController()
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return (UINavigationController *)appDelegate.window.rootViewController;
}

@interface NavigationTests : XCTestCase

@end

@implementation NavigationTests {
    UINavigationController *_nvc;
}

#pragma mark -

- (void)setUp {
    [super setUp];
    
    // Note: setup code should run after call to super
    
    if (!_nvc) {
        _nvc = GetNavigationController();
    }
}

- (void)tearDown {
    
    // Note: teardown code should run before call to super
    
    [super tearDown];
}

#pragma mark -

- (void)testRootViewController {
    XCTAssert(_nvc != nil, @"Pass");
    XCTAssert([_nvc isKindOfClass:[UINavigationController class]], @"Pass");
}

- (void)testTopViewController {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    
    [_nvc popToRootViewControllerAnimated:NO];
    
    [self watchForViewControllerAppearing:[HomeViewController class] withCompletionBlock:^{
        XCTAssert([_nvc.topViewController isKindOfClass:[HomeViewController class]], @"Pass");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kExpectationTimeout handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testHomeToOneSegue {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    
    [_nvc popToRootViewControllerAnimated:NO];
    [self watchForViewControllerAppearing:[HomeViewController class] withCompletionBlock:^{
        UIViewController *vc = _nvc.topViewController;
        
        XCTAssert([_nvc.topViewController isKindOfClass:[HomeViewController class]], @"Pass");
        
        if ([_nvc.topViewController isKindOfClass:[HomeViewController class]]) {
            [vc performSegueWithIdentifier:@"HomeToOne" sender:vc];
            [self watchForViewControllerAppearing:[OneViewController class] withCompletionBlock:^{
                UIViewController *topVC = _nvc.topViewController;
                
                XCTAssert([topVC isKindOfClass:[OneViewController class]], @"Pass");
                XCTAssert(![topVC isKindOfClass:[TwoViewController class]], @"Pass");
                XCTAssert(![topVC isKindOfClass:[HomeViewController class]], @"Pass");
                
                UIView *view = [topVC.view viewWithTag:OneButtonTag];
                
                XCTAssert(view != nil, @"Pass");
                XCTAssert([view isKindOfClass:[UIButton class]], @"Pass");
                
                [expectation fulfill];
            }];
        }
    }];
    
    [self waitForExpectationsWithTimeout:kExpectationTimeout handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testHomeToTwoSegue {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    
    [_nvc popToRootViewControllerAnimated:NO];
    [self watchForViewControllerAppearing:[HomeViewController class] withCompletionBlock:^{
        
        UIViewController *vc = _nvc.topViewController;
        
        XCTAssert([_nvc.topViewController isKindOfClass:[HomeViewController class]], @"Pass");
        
        if ([_nvc.topViewController isKindOfClass:[HomeViewController class]]) {
            // perform segue to navigate to two vc
            
            [vc performSegueWithIdentifier:@"HomeToTwo" sender:vc];
            [self watchForViewControllerAppearing:[TwoViewController class] withCompletionBlock:^{
                UIViewController *topVC = _nvc.topViewController;
                
                XCTAssert([topVC isKindOfClass:[TwoViewController class]], @"Pass");
                XCTAssert(![topVC isKindOfClass:[OneViewController class]], @"Pass");
                XCTAssert(![topVC isKindOfClass:[HomeViewController class]], @"Pass");
                
                UIView *view = [topVC.view viewWithTag:TwoButtonTag];
                
                XCTAssert(view != nil, @"Pass");
                XCTAssert([view isKindOfClass:[UIButton class]], @"Pass");
                
                [expectation fulfill];
            }];
        }
        else {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:kExpectationTimeout handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testOneButtonExists {
    UIViewController *vc = [_nvc.storyboard instantiateViewControllerWithIdentifier:@"OneVC"];

    UIView *view = [vc.view viewWithTag:OneButtonTag];
    
    XCTAssert(view != nil, @"Pass");
    XCTAssert([view isKindOfClass:[UIButton class]], @"Pass");
}

- (void)testTwoButtonExists {
    UIViewController *vc = [_nvc.storyboard instantiateViewControllerWithIdentifier:@"TwoVC"];
    
    UIView *view = [vc.view viewWithTag:TwoButtonTag];
    
    XCTAssert(view != nil, @"Pass");
    XCTAssert([view isKindOfClass:[UIButton class]], @"Pass");
}

#pragma mark - Wait for View Controller
#pragma mark -

- (void)watchForViewControllerAppearing:(Class)class withCompletionBlock:(void (^)())completionBlock {
    if (!completionBlock) {
        // do nothing
        return;
    }
    
    NSString *className = NSStringFromClass(class);
    
    if ([className isEqualToString:NSStringFromClass([_nvc.topViewController class])]) {
        // the vc has already appeared
        completionBlock();
    }
    else {
        id blockObserver;
        void (^notificationBlock)(NSNotification *notification) =  ^void (NSNotification *notification) {
            
            if ([className isEqualToString:notification.userInfo[ViewDidAppearNotificationKey]]) {
                completionBlock();
                
                [[NSNotificationCenter defaultCenter] removeObserver:blockObserver
                                                                name:ViewDidAppearNotificationName
                                                              object:nil];
            }
            
        };
        blockObserver = [[NSNotificationCenter defaultCenter] addObserverForName:ViewDidAppearNotificationName
                                                                          object:nil
                                                                           queue:[NSOperationQueue mainQueue]
                                                                      usingBlock:notificationBlock];
    }
}

@end
