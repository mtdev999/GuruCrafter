//
//  MTChoseCoursesViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTChoseCoursesViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTDataManager.h"

@interface MTChoseCoursesViewController ()

@end

@implementation MTChoseCoursesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [[MTDataManager sharedManager] managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions

- (void)actionDone:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *array = [self.fetchedResultsController fetchedObjects];
        NSUInteger count = array.count;
        
        return count;
    }
    
    return 0;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    if ([object isKindOfClass:[MTCourse class]]) {
        MTCourse *course = (MTCourse *)object;
        course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
        if ([self.university.courses containsObject:course]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTUniversity *university = self.university;
    NSMutableSet *array = [NSMutableSet setWithSet:university.courses];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    MTCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [array addObject:course];
    university.courses = array;
    
    NSError *error = nil;
    if (![[[MTDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    };
    
    self.choisedIndexPath = indexPath;
}

#pragma mark -
#pragma mark  NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MTCourse"
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
