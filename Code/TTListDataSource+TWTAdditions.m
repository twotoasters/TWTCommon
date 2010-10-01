//
//  TTListDataSource+TWTAdditions.m
//  TWTCommon
//
//  Created by Blake Watters on 9/3/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TTListDataSource+TWTAdditions.h"

@implementation TTListDataSource (TWTAdditions)

- (TTTableItem*)nextSiblingTableItemToControl:(UIControl*)control {
	NSInteger index = -1;
	NSArray* tableItems = self.items;
	for (TTTableItem* item in tableItems) {
		if ([item isKindOfClass:[TTTableControlItem class]]) {
			if (control == [(TTTableControlItem*)item control]) {
				index = [tableItems indexOfObject:item];
				break;
			}
		}
	}
	
	if (index >= 0  && index < ([tableItems count] - 1)) {
		return [tableItems objectAtIndex:index + 1];
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
