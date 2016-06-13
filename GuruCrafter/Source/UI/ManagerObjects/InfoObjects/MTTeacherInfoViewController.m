//
//  MTTeacherInfoViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTTeacherInfoViewController.h"

#import "MTTeacher.h"
#import "MTUniversity.h"
#import "TextField.h"
#import "MTDataManager.h"

#define BGColorCellEditing [UIColor colorWithRed:1.0 green:0.972 blue:0.7441 alpha:1.0];

@interface MTTeacherInfoViewController ()
@property (nonatomic, assign)   BOOL editing;

@end

@implementation MTTeacherInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Teacher Info";
    
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
        
        self.teacher.name = self.firstField.text;
        self.teacher.surname = self.secondField.text;
        self.teacher.subject = self.thridField.text;
        
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    self.cellBGView.backgroundColor = [UIColor colorWithRed:0.8392 green:0.7333 blue:0.451 alpha:0.750395903716216];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MTTeacher"
                                                   inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    [request setEntity:description];
    
    NSError *error = nil;
    NSArray *resultArray = [[[MTDataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return section == 0 ? 3 : resultArray.count;
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
    MTTeacher *teacher = self.teacher;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Name:";
            self.firstField = field;
            self.firstField.text = teacher.name;
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Surname:";
            self.secondField = field;
            self.secondField.text = teacher.surname;
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Subject:";
            self.thridField = field;
            self.thridField.text = teacher.subject;
            self.thridField.returnKeyType = UIReturnKeyDone;
        }
        
        [cell addSubview:field];
    } else {
//        if (indexPath.row == 0) {
//            cell.textLabel.textAlignment = NSTextAlignmentRight;
//            cell.textLabel.textColor = [UIColor redColor];
//            cell.textLabel.font = [UIFont systemFontOfSize:12];
//            cell.textLabel.text = @"ADD COURSE";
//        } else {
//            
//            NSArray *array = [student.corses allObjects];
//            NSLog(@"student:%@ count courses: %lu", student.name, student.corses.count);
//            NSUInteger index = indexPath.row - 1;
//            
//            MTCourse *course = [array objectAtIndex:index];
//            NSLog(@"course: %@", course.name);
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
//        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSArray *tempArray = [self.student.corses allObjects];
//        NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:tempArray];
//        
//        
//        [tempMutableArray removeObject:[tempArray objectAtIndex:indexPath.row - 1]];
//        [self.teacher setCorses:[NSSet setWithArray:tempMutableArray]];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self save];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    MTStudent *student = self.student;
//    
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        MTChoseCoursesViewController *vc = [MTChoseCoursesViewController new];
//        vc.student = student;
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//        navController.modalPresentationStyle = UIModalPresentationPageSheet;
//        [self presentViewController:navController animated:YES completion:nil];
//    } else if (indexPath.section == 1){
//        MTCourseInfoViewController *vc = [MTCourseInfoViewController new];
//        NSArray *array = [student.corses allObjects];
//        
//        vc.course = [array objectAtIndex:indexPath.row - 1];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
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
