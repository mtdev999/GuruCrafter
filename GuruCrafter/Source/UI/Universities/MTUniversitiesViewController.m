//
//  MTUniversityViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTUniversitiesViewController.h"

#import "MTAddUniversityViewController.h"
#import "MTUniversity.h"
#import "MTDataManager.h"

@interface MTUniversitiesViewController ()

@end

@implementation MTUniversitiesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Universities";
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
    NSLog(@"actionAddNewObject");
    
    MTAddUniversityViewController *vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"MTAddUniversityViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"List:";
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    if ([object isKindOfClass:[MTUniversity class]]) {
        MTUniversity *university = (MTUniversity *)object;
        if (university.name.length > 0) {
            //university = [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@", university.name];
        } else {
            [[[MTDataManager sharedManager] managedObjectContext] rollback];
        }
    }
}

#pragma mark -
#pragma mark UITableVIewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark  NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MTUniversity"
                                                   inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    NSSortDescriptor *nameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors: @[nameDescriptor]];
    
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
