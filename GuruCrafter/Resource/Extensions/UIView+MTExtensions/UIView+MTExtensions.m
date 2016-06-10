//
//  UIView+MTExtensions.m
//  Task#2
//
//  Created by Mark Tezza on 25.09.15.
//  Copyright © 2015 Mark Tezza. All rights reserved.
//

#import "UIView+MTExtensions.h"

@interface UIView ()
@property (nonatomic, strong) IBInspectable   UIColor     *borderColor;
@property (nonatomic, assign) IBInspectable   CGFloat     borderWidth;
@property (nonatomic, assign) IBInspectable   CGFloat     cornerRadius;

@end

@implementation UIView (MTExtensions)

@dynamic borderColor;
@dynamic borderWidth;
@dynamic cornerRadius;

#pragma mark -
#pragma mark Accessors

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

@end
