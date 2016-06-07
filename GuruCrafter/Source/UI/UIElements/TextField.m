//
//  TextField.m
//  CellsTest
//
//  Created by Mark Tezza on 02/06/16.
//  Copyright © 2016 MTDev. All rights reserved.
//

#import "TextField.h"

@implementation TextField

+ (UITextField *)getTextFieldWith:(CGRect)frame {
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(frame) - 208, 8, 180, 28)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo ;
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    nameTextField.returnKeyType = UIReturnKeyNext;
    nameTextField.placeholder = @"enter text here";
    nameTextField.textAlignment = NSTextAlignmentCenter;
    
    return nameTextField;
}

@end
