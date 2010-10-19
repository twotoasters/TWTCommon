//
//  TWTActionSheetDelegate.h
//  TWTCommon
//
//  Created by Timothy Kerchmar on 10/14/10.
//  Copyright 2010 The Night School, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TWTActionSheetDelegate : NSObject <UIActionSheetDelegate> {
	NSMutableDictionary* _actionsByButtonIndex;
}

- (void)setTarget:(id)target selector:(SEL)selector object:(id)object forButtonIndex:(int)buttonIndex;

@end
