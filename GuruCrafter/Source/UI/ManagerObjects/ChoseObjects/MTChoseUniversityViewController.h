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

@protocol MTChoseUniversityDelegate <NSObject>

@required
- (void)didFinishChoseUniversity:(MTUniversity *)university withIndexPath:(NSIndexPath *)indexPath;

@end

@interface MTChoseUniversityViewController : MTManagerObjectsViewController
@property (nonatomic, strong)   id<MTChoseUniversityDelegate> delegate;
@property (strong, nonatomic) NSIndexPath   *choisedIndexPath;
@property (strong, nonatomic) NSString      *nameUniversity;

@property (strong, nonatomic) MTUniversity     *university;
@property (strong, nonatomic) MTAddStudentViewController     *addStudentController;

@end
