//
//  TTSectionedDataSource+TWTAdditions.m
//  TWTCommon
//
//  Created by Blake Watters on 9/7/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TTSectionedDataSource+TWTAdditions.h"


@implementation TTSectionedDataSource (TWTAdditions)

- (TTTableItem*)nextSiblingTableItemToControl:(UIControl*)control {
	// Find the control in the list of 
	NSMutableArray* flattenedTableItems = [NSMutableArray array];
	for (NSArray* array in self.items) {
		[flattenedTableItems addObjectsFromArray:array];
	}
	
	NSInteger index = -1;
	for (TTTableItem* item in flattenedTableItems) {
		if ([item isKindOfClass:[TTTableControlItem class]]) {
			if (control == [(TTTableControlItem*)item control]) {
				index = [flattenedTableItems indexOfObject:item];
				break;
			}
		}
	}
	
	if (index >= 0  && index < ([flattenedTableItems count] - 1)) {
		return [flattenedTableItems objectAtIndex:index + 1];
	}
	
	return nil;
}

- (UIControl*)nextSiblingControlToControl:(UIControl*)control {
	TTTableItem* tableItem = [self nextSiblingTableItemToControl:control];
	if ([tableItem isKindOfClass:[TTTableControlItem class]]) {
		return [(TTTableControlItem*)tableItem control];
	}
	
	return nil;
}

@end
