//
//  BaseViewController.m
//  Navigation
//
//  Created by Brennan Stehling on 5/21/15.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // support for testing
    if ([self respondsToSelector:@selector(notifyViewDidAppearForTesting:)]) {
        [self performSelector:@selector(notifyViewDidAppearForTesting:) withObject:nil];
    }
#pragma clang diagnostic pop
    
}

@end
