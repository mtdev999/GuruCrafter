//
//  MTCoreDataViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 29/05/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MTCoreDataViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource>
@property (nonatomic, strong)   NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)   NSFetchedResultsController *fetchedResultsController;

@end
