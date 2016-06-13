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

#import "MTDataManager.h"

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
    MTTeacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"MTTeacher"
                                                       inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    
    teacher.name = self.firstField.text;
    teacher.surname = self.secondField.text;
    teacher.subject = self.thridField.text;
    
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    self.cellBGView.backgroundColor = [UIColor colorWithRed:0.8235 green:0.698 blue:0.3686 alpha:0.7];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
