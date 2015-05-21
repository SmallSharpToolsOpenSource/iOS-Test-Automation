//
//  AnimationDelegate.h
//  Navigation
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AnimationCompletionBlock)(void);

@interface AnimationDelegate : NSObject

@property (nonatomic, copy) AnimationCompletionBlock completionBlock;

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

//Your method must take the following arguments:
//animationID
//An NSString containing an optional application-supplied identifier. This is the identifier that is passed to the beginAnimations:context: method. This argument can be nil.
//finished
//An NSNumber object containing a Boolean value. The value is YES if the animation ran to completion before it stopped or NO if it did not.
//context
//An optional application-supplied context. This is the context data passed to the beginAnimations:context: method. This argument can be nil.

@end
