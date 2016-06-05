//
//  MTUniversity.m
//  GuruCrafter
//
//  Created by Mark Tezza on 03/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "MTUniversity.h"
#import "MTCourse.h"
#import "MTStudent.h"
#import "MTTeacher.h"

@interface MTUniversity ()

@end

@implementation MTUniversity

- (void)setListCategories:(NSArray *)listCategories {
    
    listCategories = [NSArray arrayWithObjects:@"Name:", @"Location:", @"Category:", nil];
}

- (NSArray *)listCategories {
    NSArray *tempArray  = [NSArray arrayWithObjects:@"Name:", @"Location:", @"Category:", nil];
    return tempArray;
}

@end
