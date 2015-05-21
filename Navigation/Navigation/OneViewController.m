//
//  OneViewController.m
//  Navigation
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "OneViewController.h"

extern NSInteger const OneButtonTag;

#pragma mark - Class Extension
#pragma mark -

@interface OneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *oneButton;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oneButton.tag = OneButtonTag;
}

@end
