//
//  MTCourseInfoViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTCourse, MTTeacher;

@interface MTCourseInfoViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   NSIndexPath *indexPath;
@property (nonatomic, strong)   MTCourse    *course;
@property (nonatomic, strong)   MTTeacher   *teacher;

@end
