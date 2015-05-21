//
//  ViewController.m
//  Navigation
//
//  Created by Brennan Stehling on 5/20/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "HomeViewController.h"

NSString * const HomeViewControllerDidAppearNotification = @"HomeViewControllerDidAppearNotification";

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"VC count: %lu", (unsigned long)self.navigationController.viewControllers.count);
    
    if ([self.navigationController.topViewController isEqual:self]) {
        NSLog(@"### Top VC is now VC");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnHome:(UIStoryboardSegue *)segue {
    NSLog(@"Returned Home");
}

@end
