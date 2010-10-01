//
//  TWTAlertViewDelegate.h
//  GoTryItOn
//
//  Created by Jeremy Ellison on 9/24/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TWTAlertViewDelegate : NSObject <UIAlertViewDelegate> {
	NSMutableDictionary* _actionsByButtonIndex;
}

- (void)setTarget:(id)target selector:(SEL)selector object:(id)object forButtonIndex:(int)buttonIndex;

@end
