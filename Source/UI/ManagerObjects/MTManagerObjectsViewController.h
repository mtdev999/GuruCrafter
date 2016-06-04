//
//  MTManagerObjectsViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTCoreDataViewController.h"

@interface MTManagerObjectsViewController : UITableViewController <NSFetchedResultsControllerDelegate> 
@property (nonatomic, strong)   NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)   NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong)       UITextField     *firstField;
@property (nonatomic, strong)       UITextField     *secondField;
@property (nonatomic, strong)       UITextField     *thridField;

- (void)save;

@end
