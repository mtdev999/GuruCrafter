//
//  MTAddCourseViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTTeacher, MTCourse;

@interface MTAddCourseViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   MTCourse    *course;
@property (nonatomic, strong)   MTTeacher   *teacher;

@end
