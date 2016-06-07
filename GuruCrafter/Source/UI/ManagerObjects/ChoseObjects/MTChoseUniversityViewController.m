//
//  MTChoseUniversityViewController.m
//  GuruCrafter
//
//  Created by Mark Tezza on 06/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTChoseUniversityViewController.h"

#import "MTDataManager.h"
#import "MTUniversity.h"
#import "MTStudent.h"

@interface MTChoseUniversityViewController ()

@end

@implementation MTChoseUniversityViewController
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

        return array.count;
    }
    
    return 0;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object indexPath:(NSIndexPath *)indexPath {
    if ([object isKindOfClass:[MTUniversity class]]) {
        MTUniversity *univer = (MTUniversity *)object;
        univer = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", univer.name];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"MTUniversity"
                                                       inManagedObjectContext:self.managedObjectContext];
        [request setEntity:description];
        
//        NSError *error = nil;
//        NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        }

        
//        if ([resultArray containsObject:univer]) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MTUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    self.addStudentController.university = university;
    NSLog(@"univer: %@", self.addStudentController.university.name);
    
    if (self.choisedIndexPath) {
        [[tableView cellForRowAtIndexPath:self.choisedIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  
    
    NSError *error = nil;
    if (![[[MTDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    };
    
    self.choisedIndexPath = indexPath;
    [self.delegate didFinishChoseUniversity:university withIndexPath:indexPath];
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
