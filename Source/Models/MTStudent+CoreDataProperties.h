//
//  MTStudent+CoreDataProperties.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTStudent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *surname;
@property (nullable, nonatomic, retain) NSSet<MTCourse *> *corses;
@property (nullable, nonatomic, retain) MTUniversity *university;

@end

@interface MTStudent (CoreDataGeneratedAccessors)

- (void)addCorsesObject:(MTCourse *)value;
- (void)removeCorsesObject:(MTCourse *)value;
- (void)addCorses:(NSSet<MTCourse *> *)values;
- (void)removeCorses:(NSSet<MTCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
