//
//  MTManagerObjectsViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTCoreDataViewController.h"

@interface MTManagerObjectsViewController : UITableViewController <NSFetchedResultsControllerDelegate,
                                                                     UITextFieldDelegate,
                                                                     UITableViewDataSource>

@property (nonatomic, strong)   NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)   NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong)       UITextField     *firstField;
@property (nonatomic, strong)       UITextField     *secondField;
@property (nonatomic, strong)       UITextField     *thridField;
@property (nonatomic, strong)       UITextField     *fourField;
@property (nonatomic, strong)       UIView          *cellBGView;

- (void)save;

@end
