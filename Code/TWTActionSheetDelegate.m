//
//  TWTActionSheetDelegate.m
//  TWTCommon
//
//  Created by Timothy Kerchmar on 10/14/10.
//  Copyright 2010 The Night School, LLC. All rights reserved.
//

#import "TWTActionSheetDelegate.h"

static NSString* const kTWTActionSheetDelegateTargetKey = @"target";
static NSString* const kTWTActionSheetDelegateSelectorKey = @"selector";
static NSString* const kTWTActionSheetDelegateObjectKey = @"object";

@implementation TWTActionSheetDelegate

+ (id)actionSheetDelegate {
	return [[[self alloc] init] autorelease];
}

- (id)init {
	if (self = [super init]) {
		_actionsByButtonIndex = [[NSMutableDictionary alloc] init];
	}
	// We hold on to ourself until a button is clicked.
	return [self retain];
}

- (void)dealloc {
	[_actionsByButtonIndex release];
	[super dealloc];
}

- (void)setTarget:(id)target selector:(SEL)selector object:(id)object forButtonIndex:(int)buttonIndex {
	NSNumber* key = [NSNumber numberWithInt:buttonIndex];
	NSDictionary* actionDict = [NSDictionary dictionaryWithObjectsAndKeys:
								target, kTWTActionSheetDelegateTargetKey,
								NSStringFromSelector(selector), kTWTActionSheetDelegateSelectorKey,
								object, kTWTActionSheetDelegateObjectKey,
								nil];
	[_actionsByButtonIndex setObject:actionDict forKey:key];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSDictionary* actionDict = [_actionsByButtonIndex objectForKey:[NSNumber numberWithInt:buttonIndex]];
	[[actionDict objectForKey:kTWTActionSheetDelegateTargetKey] 
	 performSelector:NSSelectorFromString([actionDict objectForKey:kTWTActionSheetDelegateSelectorKey]) 
	 withObject:[actionDict objectForKey:kTWTActionSheetDelegateObjectKey]];
	// Release ourselves now that we are longer needed
	[self release];
}


@end
