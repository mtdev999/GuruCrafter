//
//  MTCoreDataViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MTCoreDataViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong)   NSManagedObjectContext        *managedObjectContext;
@property (strong, nonatomic)   NSFetchedResultsController    *fetchedResultsController;

@end
