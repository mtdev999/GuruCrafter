//
//  MTMainViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 09/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTMainViewController.h"

@interface MTMainViewController () 

@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    NSArray *tabViewControllers = tabBarController.viewControllers;
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    if (fromView == toView) {
        return NO;
    } else {
        //NSUInteger fromIndex = [tabViewControllers indexOfObject:tabBarController.selectedViewController];
        NSUInteger toIndex = [tabViewControllers indexOfObject:viewController];
        
        [UIView transitionFromView:fromView
                            toView:toView
                          duration:0.3
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished) {
                            if (finished) {
                                tabBarController.selectedIndex = toIndex;
                            }
                        }];
        return YES;
    }
}

@end
