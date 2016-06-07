//
//  MTStudentInfoViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTStudent;

@interface MTStudentInfoViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   MTStudent *student;

@end
