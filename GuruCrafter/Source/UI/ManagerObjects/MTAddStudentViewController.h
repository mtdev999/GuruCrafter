//
//  MTAddStudentViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTStudent, MTUniversity;

@interface MTAddStudentViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   MTStudent *student;
@property (nonatomic, strong)   MTUniversity *university;

@end
