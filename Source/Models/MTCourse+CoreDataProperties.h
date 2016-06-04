//
//  MTCourse+CoreDataProperties.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MTCourse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTCourse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *sector;
@property (nullable, nonatomic, retain) NSString *subject;
@property (nullable, nonatomic, retain) NSSet<MTStudent *> *students;
@property (nullable, nonatomic, retain) NSSet<MTTeacher *> *techers;
@property (nullable, nonatomic, retain) MTUniversity *university;

@end

@interface MTCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(MTStudent *)value;
- (void)removeStudentsObject:(MTStudent *)value;
- (void)addStudents:(NSSet<MTStudent *> *)values;
- (void)removeStudents:(NSSet<MTStudent *> *)values;

- (void)addTechersObject:(MTTeacher *)value;
- (void)removeTechersObject:(MTTeacher *)value;
- (void)addTechers:(NSSet<MTTeacher *> *)values;
- (void)removeTechers:(NSSet<MTTeacher *> *)values;

@end

NS_ASSUME_NONNULL_END
