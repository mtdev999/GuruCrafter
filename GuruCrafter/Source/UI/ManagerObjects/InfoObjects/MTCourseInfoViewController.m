//
//  MTCourseInfoViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTCourseInfoViewController.h"

#import "MTUniversitiesViewController.h"
#import "MTChoseStudentViewController.h"
#import "MTChoseTeacherViewController.h"
#import "MTStudentInfoViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTStudent.h"
#import "MTTeacher.h"
#import "MTDataManager.h"

#import "TextField.h"

@interface MTCourseInfoViewController () <UITextFieldDelegate, MTChoseTeacherDelegate>
@property (nonatomic, strong)   NSMutableArray *tempTeashers;
@end

@implementation MTCourseInfoViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Course Info";
    
    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[MTUniversitiesViewController class]]) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                              target:self
                                                                              action:@selector(actionEdit:)];
        self.navigationItem.rightBarButtonItem = edit;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionEdit:(UIBarButtonItem *)sender {
    
}

#pragma mark -
#pragma mark UITableViewDataSource

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [cell respondsToSelector:@selector(setBackgroundColor:)]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.8039 green:0.5059 blue:0.4784 alpha:0.501266891891892]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 4 : self.course.students.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Info:": @"Students:";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    UITextField *field = [TextField getTextFieldWith:self.view.bounds];
    field.delegate = self;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Name:";
            self.firstField = field;
            self.firstField.text = self.course.name;
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Subject:";
            self.secondField = field;
            self.secondField.text = self.course.subject;
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Sector:";
            self.thridField = field;
            self.thridField.text = self.course.sector;
            self.thridField.returnKeyType = UIReturnKeyDone;
        } else {
            cell.textLabel.text = @"Teacher:";
            self.fourField = field;

            if (self.course.teachers) {
                self.fourField.text = [NSString stringWithFormat:@"%@ %@", self.course.teachers.name, self.course.teachers.surname];
                
            } else {
                self.fourField.text = @"ADD TEACHER";
                self.fourField.font = [UIFont systemFontOfSize:12];
                self.fourField.textColor = [UIColor orangeColor];
                self.fourField.placeholder = @"chose university";
            }

        }
        
        [cell addSubview:field];
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.text = @"ADD STUDENT";
        } else {
            MTCourse *course = self.course;
            NSArray *array = [course.students allObjects];
            MTStudent *student = [array objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *tempArray = [self.course.students allObjects];
        NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:tempArray];
        
        
        [tempMutableArray removeObject:[tempArray objectAtIndex:indexPath.row - 1]];
        [self.course setStudents:[NSSet setWithArray:tempMutableArray]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        MTChoseStudentViewController *vc = [MTChoseStudentViewController new];
        vc.course = self.course;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:navController animated:YES completion:nil];
    } else {
        MTStudentInfoViewController *vc = [MTStudentInfoViewController new];
        NSArray *array = [self.course.students allObjects];
        vc.student = [array objectAtIndex:indexPath.row - 1];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[MTUniversitiesViewController class]]) {
        return NO;
    }
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
    self.course.teachers = teacher;
    self.fourField.text = [NSString stringWithFormat:@"%@ %@", teacher.name, teacher.surname];
    NSLog(@"teacher: %@ %@", teacher.name, teacher.surname);
}

#pragma mark -
#pragma mark Private

- (void)showChoseTeacher {
    MTChoseTeacherViewController *vc = [MTChoseTeacherViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.delegate = self;
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
}

@end
