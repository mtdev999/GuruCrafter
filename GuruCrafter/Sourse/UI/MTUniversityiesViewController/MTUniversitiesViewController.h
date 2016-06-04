//
//  MTUniversitiesViewController.h
//  GuruCrafter
//
//  Created by Mark Tezza on 04/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTCoreDataViewController.h"

@class MTUniversity;

@interface MTUniversitiesViewController : MTCoreDataViewController
@property (nonatomic, strong)   MTUniversity    *university;

@end
