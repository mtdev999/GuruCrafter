//
//  MTChoseCoursesViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTUniversity, MTStudent;

@interface MTChoseCoursesViewController : MTManagerObjectsViewController
@property (strong, nonatomic)   NSIndexPath     *choisedIndexPath;
@property (nonatomic, strong)   MTUniversity    *university;
@property (nonatomic, strong)   MTStudent       *student;

@end
