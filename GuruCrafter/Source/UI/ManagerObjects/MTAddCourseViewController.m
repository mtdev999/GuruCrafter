//
//  MTAddCourseViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddCourseViewController.h"

#import "MTChoseTeacherViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTTeacher.h"
#import "TextField.h"

#import "MTDataManager.h"

@interface MTAddCourseViewController () <UITextFieldDelegate, UITableViewDataSource, MTChoseTeacherDelegate>

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
    if (self.teacher) {
       
        course.teachers = self.teacher;
    }
    
    
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    self.cellBGView.backgroundColor = [UIColor colorWithRed:0.8039 green:0.5059 blue:0.4784 alpha:0.7];
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
        cell.textLabel.text = @"Subject:";
        self.secondField = field;
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Sector:";
        self.thridField = field;
        
    } else {
        cell.textLabel.text = @"Teacher:";
        self.fourField = field;
        if (self.teacher) {
            self.fourField.text = [NSString stringWithFormat:@"%@ %@", self.teacher.name, self.teacher.surname];
            
        } else {
            self.fourField.text = @"ADD TEACHER";
            self.fourField.font = [UIFont systemFontOfSize:12];
            self.fourField.textColor = [UIColor orangeColor];
            self.fourField.placeholder = @"chose university";
        }
    }
    
    [cell addSubview:field];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
                MTChoseTeacherViewController *vc = [MTChoseTeacherViewController new];
//                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
////                vc.delegate = self;
////                vc. = self.university;
////                vc.addStudentController = self;
//                navController.modalPresentationStyle = UIModalPresentationPopover;
//                [self presentViewController:navController animated:YES completion:nil];
//        
//                [self.navigationController pushViewController:vc animated:YES];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        
        navController.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:navController animated:YES completion:nil];
        
        UIPopoverPresentationController *popController = [navController popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionRight;
        
        popController.sourceView = self.fourField;
        popController.sourceRect = CGRectMake(30, 50, 10, 10);
        
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.fourField]) {
        [self showChoseTeacher];
        
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark MTChoseTeacherDelegate

- (void)didFinishChoseObject:(MTTeacher *)teacher withIndexPath:(NSIndexPath *)indexPath {
    self.teacher = teacher;
    self.fourField.text = [NSString stringWithFormat:@"%@ %@", teacher.name, teacher.surname];
}

#pragma mark -
#pragma mark Private

- (void)showChoseTeacher {
    MTChoseTeacherViewController *vc = [MTChoseTeacherViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.delegate = self;
    
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [navController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionRight;
    
    popController.sourceView = self.fourField;
    popController.sourceRect = CGRectMake(30, 50, 10, 10);
}

@end
