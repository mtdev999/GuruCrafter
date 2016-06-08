//
//  MTChoseTeacherViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 05/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTManagerObjectsViewController.h"

@class MTUniversity, MTCourse, MTTeacher;

@protocol MTChoseTeacherDelegate <NSObject>

@required
- (void)didFinishChoseObject:(MTTeacher *)teacher withIndexPath:(NSIndexPath *)indexPath;

@end

@interface MTChoseTeacherViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   id <MTChoseTeacherDelegate> delegate;
@property (strong, nonatomic)   NSIndexPath     *choisedIndexPath;
@property (nonatomic, strong)   MTUniversity    *university;
@property (nonatomic, strong)   MTCourse        *course;

@end
