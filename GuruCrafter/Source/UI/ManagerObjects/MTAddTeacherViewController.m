//
//  MTAddTeacherViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddTeacherViewController.h"

#import "MTTeacher.h"
#import "TextField.h"

@interface MTAddTeacherViewController () <UITextFieldDelegate, UITableViewDataSource>

@end

@implementation MTAddTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add Teacher";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    self.teacher.name = self.firstField.text;
    self.teacher.surname = self.secondField.text;
    self.teacher.subject = self.thridField.text;
    
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Info:";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    UITextField *field = [TextField getTextFieldWith:self.view.bounds];
    field.delegate = self;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Name:";
        self.firstField = field;
        [self.firstField becomeFirstResponder];
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Surname:";
        self.secondField = field;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Main subject:";
        self.thridField = field;
    }
    
    [cell addSubview:field];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.firstField]) {
        [self.secondField becomeFirstResponder];
    } else if ([textField isEqual:self.secondField]) {
        [self.thridField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
