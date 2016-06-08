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
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                  target:self
                                                  action:@selector(actionSheetCancel:)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(actionDone:)];
}

- (void)actionSheetCancel:(id)sender {
    [self actionDone:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
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
