//
//  TWTDatePickerControl.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 9/9/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTDatePickerControl.h"

@interface TWTDatePickerControl (Private)
- (void)datePickerChanged:(id)sender;
@end


@implementation TWTDatePickerControl

- (id)initWithFrame:(CGRect)frame mode:(UIDatePickerMode)mode startDate:(NSDate*)startDate endDate:(NSDate*)endDate {
	if (self = [self initWithFrame:frame]) {
		[_picker removeFromSuperview];
		[_picker release];
		_picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 48, 320, 150)];
		[(UIDatePicker*)_picker setDatePickerMode:mode];
		[(UIDatePicker*)_picker setMinimumDate:startDate];
		[(UIDatePicker*)_picker setMaximumDate:endDate];
		[(UIDatePicker*)_picker setMinuteInterval:5];
		[(UIDatePicker*)_picker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
		[_pickerView addSubview:_picker];
		[self datePickerChanged:nil];
	}
	return self;
}

- (NSDate*)date {
	return [(UIDatePicker*)_picker date];
}

- (void)setDate:(NSDate*)date {
	[(UIDatePicker*)_picker setDate:date];
	[self datePickerChanged:self];
}

- (void)datePickerChanged:(id)sender {
	NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	
	if(UIDatePickerModeDate == [(UIDatePicker*)_picker datePickerMode]) {
		[formatter setDateFormat:@"EEE MMM d'%@'"];
	} else {
		[formatter setDateFormat:@"EEE MMM d'%@', h:mma"];
	}
	
	NSDate* date = [(UIDatePicker*)_picker date];
	NSDateComponents* components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:date];
	NSString* daySuffex;
	switch (components.day) {
		case 1:
			daySuffex = @"st";
			break;
		case 2:
			daySuffex = @"nd";
			break;
		case 3:
			daySuffex = @"rd";
			break;
		default:
			daySuffex = @"th";
			break;
	}
	_label.text = [NSString stringWithFormat:[formatter stringFromDate:date], daySuffex];
}

@end
