//
//  UIViewController+Testing.m
//  Navigation
//
//  Created by Brennan Stehling on 5/21/15.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "UIViewController+Testing.h"

NSString * const ViewDidAppearNotificationName = @"ViewDidAppearNotificationName";
NSString * const ViewDidAppearNotificationKey = @"ViewDidAppearNotificationKey";

@implementation UIViewController (Testing)

- (void)notifyViewDidAppearForTesting:(id)sender {
    NSString *className = NSStringFromClass([self class]);
    
    NSLog(@"View Did Appear: %@", className);
    
    NSDictionary *userInfo = @{ViewDidAppearNotificationKey : className};
    [[NSNotificationCenter defaultCenter] postNotificationName:ViewDidAppearNotificationName
                                                        object:nil
                                                      userInfo:userInfo];
}

@end
