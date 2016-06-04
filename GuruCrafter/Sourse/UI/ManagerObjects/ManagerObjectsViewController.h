//
//  ManagerObjectsViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerObjectsViewController : UITableViewController
@property (nonatomic, strong)   NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)       UITextField     *firstField;
@property (nonatomic, strong)       UITextField     *secondField;
@property (nonatomic, strong)       UITextField     *thridField;

- (void)save;

@end
