//
//  MTManagerObjectsViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

#import "TextField.h"
#import "MTUniversity.h"

#import "MTDataManager.h"

@interface MTManagerObjectsViewController () <UITextFieldDelegate>

@end

@implementation MTManagerObjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(actionDone:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)save {
    NSError *error = nil;
    if (![[[MTDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    NSLog(@"actionDone Manager");
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    NSLog(@"object description: %@", object.description);
    
    [self configureCell:cell withObject:object indexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
