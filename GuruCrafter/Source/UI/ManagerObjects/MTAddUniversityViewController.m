//
//  MTAddUniversityViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddUniversityViewController.h"

#import "MTDatePickerViewController.h"
#import "MTUniversity.h"
#import "TextField.h"

#import "MTDataManager.h"

@interface MTAddUniversityViewController () <UITextFieldDelegate, UITableViewDataSource, MTDatePickerDelegate>
@property (nonatomic, strong)   NSDate *currentDate;

@end

@implementation MTAddUniversityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add University";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    MTUniversity *university = [NSEntityDescription insertNewObjectForEntityForName:@"MTUniversity"
                                                         inManagedObjectContext:[[MTDataManager sharedManager] managedObjectContext]];
    
    university.name = self.firstField.text;
    university.location = self.secondField.text;
    university.foundingDate = self.currentDate;
    
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
        
        [cell addSubview:field];

    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Location:";
        self.secondField = field;
        [cell addSubview:field];
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Founding Date:";
        self.thridField = field;
        if (self.currentDate) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
            self.thridField.text = [dateFormatter stringFromDate:self.currentDate];
        }
        
        [cell addSubview:field];
    }
    
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.thridField]) {
        [self showDatePicker];
        
        return NO;
    }
    
    return YES;
}

- (void)showDatePicker {
    MTDatePickerViewController *dateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MTDatePickerViewController"];
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
