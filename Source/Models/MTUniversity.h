//
//  MTUniversity.h
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTParentObject.h"

@class MTCourse, MTStudent, MTTeacher;

NS_ASSUME_NONNULL_BEGIN

@interface MTUniversity : MTParentObject
@property (nonatomic, strong) NSArray *listCategories;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "MTUniversity+CoreDataProperties.h"
