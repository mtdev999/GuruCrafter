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

@property (nullable, nonatomic, retain) NSString *surname;
@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) MTUniversity *university;
@property (nullable, nonatomic, retain) NSSet<MTCourse *> *courses;

@end

@interface MTStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(MTCourse *)value;
- (void)removeCoursesObject:(MTCourse *)value;
- (void)addCourses:(NSSet<MTCourse *> *)values;
- (void)removeCourses:(NSSet<MTCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
