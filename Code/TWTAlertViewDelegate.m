//
//  TWTAlertViewDelegate.m
//  GoTryItOn
//
//  Created by Jeremy Ellison on 9/24/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTAlertViewDelegate.h"

static NSString* const kTWTAlertViewDelegateTargetKey = @"target";
static NSString* const kTWTAlertViewDelegateSelectorKey = @"selector";
static NSString* const kTWTAlertViewDelegateObjectKey = @"object";

@implementation TWTAlertViewDelegate

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
								target, kTWTAlertViewDelegateTargetKey,
								NSStringFromSelector(selector), kTWTAlertViewDelegateSelectorKey,
								object, kTWTAlertViewDelegateObjectKey,
								nil];
	[_actionsByButtonIndex setObject:actionDict forKey:key];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSDictionary* actionDict = [_actionsByButtonIndex objectForKey:[NSNumber numberWithInt:buttonIndex]];
	[[actionDict objectForKey:kTWTAlertViewDelegateTargetKey] 
	 performSelector:NSSelectorFromString([actionDict objectForKey:kTWTAlertViewDelegateSelectorKey]) 
		  withObject:[actionDict objectForKey:kTWTAlertViewDelegateObjectKey]];
	// Release ourselves now that we are longer needed
	[self release];
}

@end
