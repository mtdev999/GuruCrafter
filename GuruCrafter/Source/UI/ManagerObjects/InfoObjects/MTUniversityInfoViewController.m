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

#define BGColorCellEditing [UIColor colorWithRed:1.0 green:0.972 blue:0.7441 alpha:1.0];

@interface MTUniversityInfoViewController () <UITextFieldDelegate>
@property (nonatomic, assign)   BOOL editing;

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
    [self actionSaveChangedInfo];
}



- (void)actionSaveChangedInfo{
    if (self.firstField.text.length > 0
        && self.secondField.text.length > 0) {
        
        self.university.name = self.firstField.text;
        self.university.location = self.secondField.text;
        
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
            self.thridField.returnKeyType = UIReturnKeyDone;
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
    if (self.editing) {
        
        return YES;
    } else {
        
        return NO;
    }
}

@end
