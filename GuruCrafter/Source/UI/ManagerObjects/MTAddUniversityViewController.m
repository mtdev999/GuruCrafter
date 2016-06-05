//
//  MTAddUniversityViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTAddUniversityViewController.h"

#import "MTUniversity.h"
#import "TextField.h"

#import "MTDataManager.h"

@interface MTAddUniversityViewController () <UITextFieldDelegate, UITableViewDataSource>

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
//    self.university.foundingDate = self.firstField.text;
    
    NSLog(@"%@", self.firstField.text);
    
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

    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Location:";
        self.secondField = field;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Category:";
        self.thridField = field;
    }
    
    [cell addSubview:field];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
