//
//  MTStudentInfoViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTStudentInfoViewController.h"


#import "MTChoseCoursesViewController.h"
#import "MTCourseInfoViewController.h"

#import "MTStudent.h"
#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTDataManager.h"
#import "TextField.h"

#define BGColorCellEditing [UIColor colorWithRed:1.0 green:0.972 blue:0.7441 alpha:1.0];

@interface MTStudentInfoViewController ()
@property (nonatomic, assign)   BOOL editing;

@end

@implementation MTStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Student Info";
    
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

- (void)actionDone:(id)sender {
    if (self.firstField.text.length > 0
        && self.secondField.text.length > 0) {
        
        self.student.name = self.firstField.text;
        self.student.surname = self.secondField.text;
        self.student.email = self.thridField.text;
        
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
        [cell setBackgroundColor:[UIColor colorWithRed:0.2941 green:0.6 blue:0.7804 alpha:0.504671663851351]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 4 : self.student.corses.count + 1;
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
    MTStudent *student = self.student;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Name:";
            self.firstField = field;
            self.firstField.text = student.name;
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Surname:";
            self.secondField = field;
            self.secondField.text = student.surname;
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"E-mail:";
            self.thridField = field;
            self.thridField.text = student.email;
            self.thridField.returnKeyType = UIReturnKeyDone;
        } else if (indexPath.row == 3){
            cell.textLabel.text = @"University:";
            self.fourField = field;
            self.fourField.text = student.university.name;
        }
        
        [cell addSubview:field];
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.text = @"ADD COURSE";
        } else {
            
            NSArray *array = [student.corses allObjects];
            NSLog(@"student:%@ count courses: %lu", student.name, student.corses.count);
            NSUInteger index = indexPath.row - 1;
            
            MTCourse *course = [array objectAtIndex:index];
            NSLog(@"course: %@", course.name);
            cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *tempArray = [self.student.corses allObjects];
        NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:tempArray];
        
        
        [tempMutableArray removeObject:[tempArray objectAtIndex:indexPath.row - 1]];
        [self.student setCorses:[NSSet setWithArray:tempMutableArray]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self save];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTStudent *student = self.student;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        MTChoseCoursesViewController *vc = [MTChoseCoursesViewController new];
        vc.student = student;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:navController animated:YES completion:nil];
    } else if (indexPath.section == 1){
        MTCourseInfoViewController *vc = [MTCourseInfoViewController new];
        NSArray *array = [student.corses allObjects];
        
        vc.course = [array objectAtIndex:indexPath.row - 1];
        [self.navigationController pushViewController:vc animated:YES];
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
