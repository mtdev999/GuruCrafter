//
//  MTDatePickerViewController.m
//  MTPopoverTest
//
//  Created by Mark Tezza on 13/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTDatePickerViewController.h"

@implementation MTDatePickerViewController

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Setting Date";
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(actionDone:)];
    self.navigationItem.rightBarButtonItem = doneItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"MTDatePickerViewController is deallocated");
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionDateDidChange:(UIDatePicker *)sender {
   [self.delegate didFinishEditingDate:sender.date];
    self.foundingDate = sender.date;
}

@end
