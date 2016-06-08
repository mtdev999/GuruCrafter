//
//  MTUniversityInfoViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTUniversityInfoViewController.h"

#import "MTChoseCoursesViewController.h"
#import "MTDatePickerViewController.h"
#import "MTCourseInfoViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTTeacher.h"
#import "MTStudent.h"

#import "TextField.h"

#define BGColorCellEditing [UIColor colorWithRed:1.0 green:0.972 blue:0.7441 alpha:1.0];

@interface MTUniversityInfoViewController () <UITextFieldDelegate, MTDatePickerDelegate>
@property (nonatomic, assign)   BOOL editing;
@property (nonatomic, strong)   NSDate *currentDate;

@end

@implementation MTUniversityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"University Info";
    
   


    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = edit;
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
    self.tableView.editing = NO;

    self.editing = YES;

    [self.firstField becomeFirstResponder];
    self.firstField.backgroundColor = BGColorCellEditing
    self.secondField.backgroundColor = BGColorCellEditing
    self.thridField.backgroundColor = BGColorCellEditing
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(actionDone:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    
}

- (void)actionDone:(UIBarButtonItem *)sender {
    if (self.firstField.text.length > 0
        && self.secondField.text.length > 0) {
        
        self.university.name = self.firstField.text;
        self.university.location = self.secondField.text;
        if (self.currentDate) {
            self.university.foundingDate = self.currentDate;
        }

        
        NSLog(@"%@", [NSString stringWithFormat:@"%@", self.university.foundingDate]);
        
        [self save];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showAlertInfo];
    }
}

- (void)showAlertInfo {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"WARNING!"
                                                                        message:@"You should not have empty cells."
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleCancel
                                               handler:nil];
    
    [controller addAction:ok];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableViewDataSource

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [cell respondsToSelector:@selector(setBackgroundColor:)]) {
        [cell setBackgroundColor:[UIColor colorWithRed:0.2667 green:0.6353 blue:0.6941 alpha:0.5]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return section == 0 ? 3 : self.university.courses.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"Info:": @"Courses:";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    UITextField *field = [TextField getTextFieldWith:self.view.bounds];
    field.delegate = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [self.university.listCategories objectAtIndex:indexPath.row];//@"Name:";
            self.firstField = field;
            self.firstField.text = self.university.name;
            
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Location:";
            self.secondField = field;
            self.secondField.text = self.university.location;
            
        } else if (indexPath.row == 2) {
            
            cell.textLabel.text = @"Founding Date:";
            self.thridField = field;
            self.thridField.returnKeyType = UIReturnKeyDone;
            if (self.currentDate) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
                self.thridField.text = [dateFormatter stringFromDate:self.currentDate];
            } else {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
                self.thridField.text = [dateFormatter stringFromDate:self.university.foundingDate];
            }
            
            NSLog(@"%@", self.thridField.text);
            
        }
        
        [cell addSubview:field];
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.text = @"ADD COURSE";
        } else {
            MTUniversity *univer = self.university;
            NSArray *array = [univer.courses allObjects];
            MTCourse *course = [array objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ ", course.name];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *tempArray = [self.university.courses allObjects];
        NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:tempArray];
        
        
        [tempMutableArray removeObject:[tempArray objectAtIndex:indexPath.row - 1]];
        [self.university setCourses:[NSSet setWithArray:tempMutableArray]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        MTChoseCoursesViewController *vc = [MTChoseCoursesViewController new];
        vc.university = self.university;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:navController animated:YES completion:nil];
    } else {
        MTCourseInfoViewController *vc = [MTCourseInfoViewController new];
        NSArray *array = [self.university.courses allObjects];
        
        vc.course = [array objectAtIndex:indexPath.row - 1];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.editing) {
        if ([textField isEqual:self.thridField]) {
            [self showDatePicker];
        }
        
        return YES;
    }
        
    return NO;
}

- (void)showDatePicker {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MTDatePickerViewController *dateViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"MTDatePickerViewController"];
    dateViewController.delegate = self;
    
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dateViewController];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark -
#pragma mark Data Picker Delegate

- (void)didFinishEditingDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    self.thridField.text = [dateFormatter stringFromDate:date];
    self.currentDate = date;
}

@end
