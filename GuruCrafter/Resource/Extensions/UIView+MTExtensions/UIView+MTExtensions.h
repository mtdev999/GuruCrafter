//
//  UIView+MTExtensions.h
//  Task#2
//
//  Created by Mark Tezza on 25.09.15.
//  Copyright © 2015 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTExtensions)
@property (nonatomic, readonly) IBInspectable   UIColor     *borderColor;
@property (nonatomic, readonly) IBInspectable   CGFloat     borderWidth;
@property (nonatomic, readonly) IBInspectable   CGFloat     cornerRadius;

@end
