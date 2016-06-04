//
//  MTParentObject+CoreDataProperties.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTParentObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTParentObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
