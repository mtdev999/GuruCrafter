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
#import "MTStudent.h"
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    self.cellBGView.backgroundColor = [UIColor colorWithRed:0.2667 green:0.6353 blue:0.6941 alpha:0.7];
    [cell setSelected:NO];
}

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
        
        if ([self.student.corses containsObject:course]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    MTUniversity *university = self.university;
    MTStudent *student = self.student;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (self.university) {
            
            NSMutableSet *array = [NSMutableSet setWithSet:university.courses];
            
            [array removeObject:course];
            university.courses = array;
        }
        if (self.student) {
            
            NSMutableSet *array = [NSMutableSet setWithSet:student.corses];
            [array removeObject:course];
            student.corses = array;
        }
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (self.university) {
            NSMutableSet *array = [NSMutableSet setWithSet:university.courses];
            
            [array addObject:course];
            university.courses = array;
        }
        
        if (self.student) {
            NSMutableSet *array = [NSMutableSet setWithSet:student.corses];
            [array addObject:course];
            student.corses = array;
        }
    }

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
