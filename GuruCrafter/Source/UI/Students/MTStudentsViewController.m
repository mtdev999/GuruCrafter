//
//  MTStudentsViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTStudentsViewController.h"

#import "MTAddStudentViewController.h"
#import "MTStudentInfoViewController.h"
#import "MTStudent.h"
#import "MTDataManager.h"

@interface MTStudentsViewController ()

@end

@implementation MTStudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Students";
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

- (void)actionAddNewObject:(UIBarButtonItem *)sender {
    MTAddStudentViewController *vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"MTAddStudentViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"List:";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    if ([object isKindOfClass:[MTStudent class]]) {
        MTStudent *student = (MTStudent *)object;
        if (student.name.length > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
        } else {
            [[[MTDataManager sharedManager] managedObjectContext] rollback];
        }
    }
}

#pragma mark -
#pragma mark UITableVIewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTStudentInfoViewController *vc = [[MTStudentInfoViewController alloc] init];
    MTStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    vc.student = student;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -
#pragma mark  NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MTStudent"
                                                   inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *surnameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"surname" ascending:YES];
    [fetchRequest setSortDescriptors: @[nameDescriptor, surnameDescriptor]];

    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

@end
