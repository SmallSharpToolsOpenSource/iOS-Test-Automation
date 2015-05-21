//
//  NavigationTests.m
//  NavigationTests
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AnimationDelegate.h"

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

#define kExpectationTimeout 5.0
#define kAnimationDuration 2.0
#define kAnimationDelayType AnimationDelayTypeDefault

typedef NS_ENUM(NSUInteger, AnimationDelayType) {
    AnimationDelayTypeDefault = 0,
    AnimationDelayTypeCAAnimation = 1,
    AnimationDelayTypeUIView = 2
};

CG_INLINE UINavigationController *GetNavigationController()
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return (UINavigationController *)appDelegate.window.rootViewController;
}

@interface NavigationTests : XCTestCase

@property (assign) AnimationDelayType animationDelayType;

@property (strong, nonatomic) AnimationDelegate *animationDelegate;

@end

@implementation NavigationTests {
    UINavigationController *_nvc;
}

#pragma mark -

- (void)setUp {
    [super setUp];
    
    // Note: setup code should run after call to super
    
    self.animationDelayType = kAnimationDelayType;
    
    if (!_nvc) {
        _nvc = GetNavigationController();
    }
}

- (void)tearDown {
    
    // Note: teardown code should run before call to super
    
    self.animationDelegate = nil;
    
    [super tearDown];
}

#pragma mark -

- (void)testRootViewController {
    NSLog(@"### %@", NSStringFromSelector(_cmd));
    
    XCTAssert(_nvc != nil, @"Pass");
    XCTAssert([_nvc isKindOfClass:[UINavigationController class]], @"Pass");
}

- (void)testTopViewController {
    NSLog(@"### %@", NSStringFromSelector(_cmd));
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    NSLog(@"### top: %@", NSStringFromClass([_nvc.topViewController class]));
    
    [self popToHomeWithCompletionBlock:^{
        NSLog(@"Popped to Home VC");
        NSLog(@"### top: %@", NSStringFromClass([_nvc.topViewController class]));

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
    NSLog(@"### %@", NSStringFromSelector(_cmd));
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    
    [self popToHomeWithCompletionBlock:^{
        NSLog(@"Popped to Home VC");
        
        UIViewController *vc = _nvc.topViewController;
        
        XCTAssert([_nvc.topViewController isKindOfClass:[HomeViewController class]], @"Pass");
        
        NSLog(@"### top: %@ (before)", NSStringFromClass([_nvc.topViewController class]));
        
        if ([_nvc.topViewController isKindOfClass:[HomeViewController class]]) {
            // perform segue to navigate to one vc
            [self performSegueWithIdentifier:@"HomeToOne" viewController:vc withCompletionBlock:^{
                NSLog(@"### top: %@ (after)", NSStringFromClass([_nvc.topViewController class]));
                
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
    NSLog(@"### %@", NSStringFromSelector(_cmd));
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
    
    [self popToHomeWithCompletionBlock:^{
        NSLog(@"### top: %@ (before)", NSStringFromClass([_nvc.topViewController class]));
        
        UIViewController *vc = _nvc.topViewController;
        
        XCTAssert([_nvc.topViewController isKindOfClass:[HomeViewController class]], @"Pass");

        if ([_nvc.topViewController isKindOfClass:[HomeViewController class]]) {
            // perform segue to navigate to two vc
            [self performSegueWithIdentifier:@"HomeToTwo" viewController:vc withCompletionBlock:^{
                NSLog(@"### top: %@ (after)", NSStringFromClass([_nvc.topViewController class]));
                
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

#pragma mark -

/*
 XCTestExpectation *expectation = [self expectationWithDescription:@"Wait to Pop"];
 
 [self popToHomeWithCompletionBlock:^{
 [expectation fulfill];
 }];
 
 [self waitForExpectationsWithTimeout:kExpectationTimeout handler:^(NSError *error) {
 if (error) {
 NSLog(@"Error: %@", error);
 }
 }];
 */

#pragma mark - Pop To Home
#pragma mark -

- (void)popToHomeWithCompletionBlock:(void (^)())completionBlock {
    if (!completionBlock) {
        // do nothing
        return;
    }
    
    if (self.animationDelayType == AnimationDelayTypeCAAnimation) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:kAnimationDuration];
        [CATransaction setCompletionBlock:completionBlock];
        [_nvc popToRootViewControllerAnimated:YES];
        [CATransaction commit];
    }
    else if (self.animationDelayType == AnimationDelayTypeUIView) {
        AnimationDelegate *animationDelegate = [[AnimationDelegate alloc] init];
        animationDelegate.completionBlock = completionBlock;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kAnimationDuration];
        [UIView setAnimationDelegate:animationDelegate];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [_nvc popToRootViewControllerAnimated:YES];
        [UIView commitAnimations];
    }
    else {
        [_nvc popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            completionBlock();
        });
    }
}

#pragma mark - Perform Segue
#pragma mark -

- (void)performSegueWithIdentifier:(NSString *)identifier viewController:(UIViewController *)vc withCompletionBlock:(void (^)())completionBlock {
    if (!completionBlock) {
        // do nothing
        return;
    }
    
    if (self.animationDelayType == AnimationDelayTypeCAAnimation) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:kAnimationDuration];
        [CATransaction setCompletionBlock:completionBlock];
        [vc performSegueWithIdentifier:identifier sender:vc];
        [CATransaction commit];
    }
    else if (self.animationDelayType == AnimationDelayTypeUIView) {
        AnimationDelegate *animationDelegate = [[AnimationDelegate alloc] init];
        animationDelegate.completionBlock = completionBlock;
        self.animationDelegate = animationDelegate; // hold onto the delegate (strong)
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:kAnimationDuration];
        [UIView setAnimationDelegate:animationDelegate];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [vc performSegueWithIdentifier:identifier sender:vc];
        [UIView commitAnimations];
    }
    else {
        [vc performSegueWithIdentifier:identifier sender:vc];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            completionBlock();
        });
    }
}

@end
