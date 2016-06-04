//
//  MTDataManager.h
//  GuruCrafter
//
//  Created by Mark Tezza on 29/05/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MTStudent, MTCourse;

@interface MTDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

+ (MTDataManager *)sharedManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
