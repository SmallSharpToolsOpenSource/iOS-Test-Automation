//
//  AnimationDelegate.m
//  Navigation
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "AnimationDelegate.h"

@implementation AnimationDelegate

// Selector: animationDidStop:finished:context:
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end
