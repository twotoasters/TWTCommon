//
//  TWTPickerDataSource.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 9/9/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTPickerDataSource.h"

@implementation TWTPickerDataSource

@synthesize components = _components;

- (id)initWithComponents:(NSArray*)components {
	if (self = [super init]) {
		_components = [components copy];
	}
	return self;
}

- (id)initWithRows:(NSArray*)rows {
	return [self initWithComponents:[NSArray arrayWithObject:rows]];
}

- (void)dealloc {
	[_components release];
	_components = nil;
	[super dealloc];
}

@end
