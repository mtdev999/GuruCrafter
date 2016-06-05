//
//  MTUniversity+CoreDataProperties.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTUniversity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTUniversity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *foundingDate;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<MTCourse *> *courses;
@property (nullable, nonatomic, retain) NSSet<MTTeacher *> *teachers;
@property (nullable, nonatomic, retain) NSSet<MTStudent *> *students;

@end

@interface MTUniversity (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(MTCourse *)value;
- (void)removeCoursesObject:(MTCourse *)value;
- (void)addCourses:(NSSet<MTCourse *> *)values;
- (void)removeCourses:(NSSet<MTCourse *> *)values;

- (void)addTeachersObject:(MTTeacher *)value;
- (void)removeTeachersObject:(MTTeacher *)value;
- (void)addTeachers:(NSSet<MTTeacher *> *)values;
- (void)removeTeachers:(NSSet<MTTeacher *> *)values;

- (void)addStudentsObject:(MTStudent *)value;
- (void)removeStudentsObject:(MTStudent *)value;
- (void)addStudents:(NSSet<MTStudent *> *)values;
- (void)removeStudents:(NSSet<MTStudent *> *)values;

@end

NS_ASSUME_NONNULL_END
