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

@interface MTAddStudentViewController () <UITextFieldDelegate, UITableViewDataSource, MTChoseUniversityDelegate>

@end

@implementation MTAddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add Student";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    
    MTStudent *student = [NSEntityDescription insertNewObjectForEntityForName:@"MTStudent"
                                                       inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    
    student.name = self.firstField.text;
    student.surname = self.secondField.text;
    student.email = self.thridField.text;
    student.university.name = self.fourField.text;
    student.university = self.university;

    
    [self save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    self.cellBGView.backgroundColor = [UIColor colorWithRed:0.2941 green:0.6 blue:0.7804 alpha:0.7];
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
        self.firstField.placeholder = @"enter first name";
        [self.firstField becomeFirstResponder];
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Surname:";
        self.secondField = field;
        self.secondField.placeholder = @"enter second name";
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"E-mail:";
        self.thridField = field;
        self.thridField.placeholder = @"enter e-mail";
        
    } else {
        cell.textLabel.text = @"University:";
        self.fourField = field;
        
        if (self.university) {
            self.fourField.text = self.university.name;
            
        } else {
            self.fourField.text = @"ADD UNIVERSITY";
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
//        MTChoseUniversityViewController *vc = [MTChoseUniversityViewController new];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//        vc.delegate = self;
//        vc.university = self.university;
//        vc.addStudentController = self;
//        navController.modalPresentationStyle = UIModalPresentationPopover;
//        [self presentViewController:navController animated:YES completion:nil];
        
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)showChoseUniversity {
    MTChoseUniversityViewController *vc = [MTChoseUniversityViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.delegate = self;
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.fourField]) {
        [self showChoseUniversity];
        
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark MTChoseUniversityDelegate

- (void)didFinishChoseUniversity:(MTUniversity *)university withIndexPath:(NSIndexPath *)indexPath {
    self.fourField.text = university.name;
    self.university = university;
}

@end
