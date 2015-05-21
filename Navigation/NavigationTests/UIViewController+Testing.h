//
//  UIViewController+Testing.h
//  Navigation
//
//  Created by Brennan Stehling on 5/21/15.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ViewDidAppearNotificationName;
extern NSString * const ViewDidAppearNotificationKey;

@interface UIViewController (Testing)

- (void)notifyViewDidAppearForTesting:(id)sender;

@end
