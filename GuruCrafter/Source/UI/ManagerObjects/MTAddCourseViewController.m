//
//  MTAddCourseViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddCourseViewController.h"

#import "MTCourse.h"
#import "TextField.h"

#import "MTDataManager.h"

@interface MTAddCourseViewController () <UITextFieldDelegate, UITableViewDataSource>

@end

@implementation MTAddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add Course";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    
    MTCourse *course = [NSEntityDescription insertNewObjectForEntityForName:@"MTCourse"
                                                     inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    
    course.name = self.firstField.text;
    course.subject = self.secondField.text;
    course.sector = self.thridField.text;
    
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
        cell.textLabel.text = @"Subject:";
        self.secondField = field;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Sector:";
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
