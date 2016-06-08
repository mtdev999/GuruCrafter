//
//  MTChoseTeacherViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTChoseTeacherViewController.h"

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTTeacher.h"
#import "MTDataManager.h"

@interface MTChoseTeacherViewController ()

@end

@implementation MTChoseTeacherViewController
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([object isKindOfClass:[MTTeacher class]]) {
        MTTeacher *teacher = (MTTeacher *)object;
        teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.name, teacher.surname];
        if ([self.university.teachers containsObject:teacher]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTCourse *course = self.course;
    NSMutableSet *array = [NSMutableSet setWithSet:course.teachers];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    MTTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [array addObject:teacher];
    course.teachers = array;
    
    NSLog(@"course.teachers: %@", course.teachers);
    
    NSError *error = nil;
    if (![[[MTDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    };
    
    self.choisedIndexPath = indexPath;
    [self.delegate didFinishChoseObject:teacher withIndexPath:indexPath];
}

#pragma mark -
#pragma mark  NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"MTTeacher"
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
