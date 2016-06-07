//
//  MTAddStudentViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddStudentViewController.h"

#import "MTChoseUniversityViewController.h"

#import "MTUniversity.h"
#import "MTStudent.h"
#import "MTDataManager.h"

#import "TextField.h"

@interface MTAddStudentViewController () <UITextFieldDelegate, UITableViewDataSource>

@end

@implementation MTAddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add Student";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    
    MTStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"MTStudent"
                                                       inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    
    student.name = self.firstField.text;
    student.surname = self.secondField.text;
    student.email = self.thridField.text;
    
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
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
        
        [cell addSubview:field];
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Surname:";
        self.secondField = field;
        [cell addSubview:field];
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"E-mail:";
        self.thridField = field;
        [cell addSubview:field];
        
    } else {
        cell.textLabel.text = @"University:";
        
        if (self.university) {
            [cell addSubview:field];
            self.fourField.text = self.university.name;
            
            NSLog(@"univer name: %@", self.university.name);
            
//            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            
            //[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - 208, 8, 180, 28)];
            label.text = @"ADD UNIVER";
            
            
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor orangeColor];
            label.font = [UIFont systemFontOfSize:12];
            label.text = @"ADD UNIVERSITY";
            
            [cell addSubview:label];
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        MTChoseUniversityViewController *vc = [MTChoseUniversityViewController new];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.university = self.university;
        vc.addStudentController = self;
        navController.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:navController animated:YES completion:nil];
        
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}


@end
