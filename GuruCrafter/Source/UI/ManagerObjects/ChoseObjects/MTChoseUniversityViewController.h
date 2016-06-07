//
//  MTChoseUniversityViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 06/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

#import "MTAddStudentViewController.h"

@class MTUniversity;

@interface MTChoseUniversityViewController : MTManagerObjectsViewController
@property (strong, nonatomic) NSIndexPath   *choisedIndexPath;
@property (strong, nonatomic) MTUniversity     *university;
@property (strong, nonatomic) MTAddStudentViewController     *addStudentController;

@end
