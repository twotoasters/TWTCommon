//
//  TWTGroupedPickerControl.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 12/3/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTGroupedPickerControl.h"


@implementation TWTGroupedPickerControl

- (NSArray*)rowsForComponent:(NSInteger)component replaceOptionTitlesWithNULL:(BOOL)replace {
	NSArray* componentArray = [_dataSource.components objectAtIndex:component];
	// [{key => [values], {key => [values]] 
	NSMutableArray* totalObjects = [NSMutableArray array];
	for(NSDictionary* componentDict in componentArray) {
		assert([[componentDict allKeys] count] == 1);
		for (NSString* key in [componentDict allKeys]) {
			[totalObjects addObject:(replace ? [NSNull null] : key)];
			[totalObjects addObjectsFromArray:[componentDict valueForKey:key]];
		}
	}
	return totalObjects;
}

// Picker View DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return [_dataSource.components count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSArray* totalObjects = [self rowsForComponent:component replaceOptionTitlesWithNULL:NO];
	return [totalObjects count];
}

- (BOOL)isOptionTitleRow:(NSInteger)row forComponent:(NSInteger)component {
	NSArray* totalObjects = [self rowsForComponent:component replaceOptionTitlesWithNULL:YES];
	return [[totalObjects objectAtIndex:row] isKindOfClass:[NSNull class]];
}

// Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSArray* totalObjects = [self rowsForComponent:component replaceOptionTitlesWithNULL:NO];
	return [totalObjects objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	// test to see if this is a key or a value
	if ([self isOptionTitleRow:row forComponent:component]) {
		row++;
		[pickerView selectRow:row inComponent:component animated:YES];
	}
	[super pickerView:pickerView didSelectRow:row inComponent:component];
}
		 

@end
