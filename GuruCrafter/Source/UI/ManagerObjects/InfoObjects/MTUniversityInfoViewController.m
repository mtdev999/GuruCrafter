//
//  MTUniversityInfoViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTUniversityInfoViewController.h"

#import "MTChoseCoursesViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTTeacher.h"
#import "MTStudent.h"

#import "TextField.h"

@interface MTUniversityInfoViewController () <UITextFieldDelegate>

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
    
}

#pragma mark -
#pragma mark UITableViewDataSource

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
            cell.textLabel.text = @"Category:";
            self.thridField = field;
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
        
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
