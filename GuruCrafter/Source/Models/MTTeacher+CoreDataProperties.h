//
//  MTTeacher+CoreDataProperties.h
//  GuruCrafter
//
//  Created by Mark Tezza on 09/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTTeacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTTeacher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *subject;
@property (nullable, nonatomic, retain) NSString *surname;
@property (nullable, nonatomic, retain) NSSet<MTCourse *> *courses;
@property (nullable, nonatomic, retain) MTUniversity *university;

@end

@interface MTTeacher (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(MTCourse *)value;
- (void)removeCoursesObject:(MTCourse *)value;
- (void)addCourses:(NSSet<MTCourse *> *)values;
- (void)removeCourses:(NSSet<MTCourse *> *)values;

@end

NS_ASSUME_NONNULL_END
