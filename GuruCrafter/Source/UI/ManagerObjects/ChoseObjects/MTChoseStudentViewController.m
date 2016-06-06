//
//  MTChoseStudentViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTChoseStudentViewController.h"

#import "MTCourse.h"
#import "MTStudent.h"
#import "MTDataManager.h"

@interface MTChoseStudentViewController ()

@end

@implementation MTChoseStudentViewController
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
    if ([object isKindOfClass:[MTStudent class]]) {
        MTStudent *student = (MTStudent *)object;
        student = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
        if ([self.course.students containsObject:student]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTCourse *course = self.course;
    NSMutableSet *array = [NSMutableSet setWithSet:course.students];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    MTStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [array addObject:student];
    course.students = array;
    
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
