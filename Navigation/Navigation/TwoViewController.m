//
//  TwoViewController.m
//  Navigation
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015 Striiv. All rights reserved.
//

#import "TwoViewController.h"

NSInteger const TwoButtonTag = 2001;

#pragma mark - Class Extension
#pragma mark -

@interface TwoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *twoButton;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.twoButton.tag = TwoButtonTag;
}

@end
