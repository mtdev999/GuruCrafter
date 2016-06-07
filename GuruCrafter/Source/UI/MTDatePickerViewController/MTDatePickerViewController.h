//
//  MTDatePickerViewController.h
//  MTPopoverTest
//
//  Created by Mark Tezza on 13/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTDatePickerDelegate <NSObject>

@required
- (void)didFinishEditingDate:(NSDate *)date;

@end

@interface MTDatePickerViewController : UIViewController

@property (strong, nonatomic) id <MTDatePickerDelegate> delegate;
@property (strong, nonatomic)           NSDate          *foundingDate;
@property (strong, nonatomic)     IBOutlet      UIDatePicker    *dateOfDatePicker;

- (IBAction)actionDateDidChange:(UIDatePicker *)sender;

@end
