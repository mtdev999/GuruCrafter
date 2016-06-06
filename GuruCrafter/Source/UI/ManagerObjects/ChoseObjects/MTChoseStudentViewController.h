//
//  MTChoseStudentViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTCourse;

@interface MTChoseStudentViewController : MTManagerObjectsViewController
@property (strong, nonatomic) NSIndexPath   *choisedIndexPath;
@property (nonatomic, strong)   MTCourse *course;

@end
