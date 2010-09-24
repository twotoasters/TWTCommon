//
//  UIView+TWTAdditions.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 8/26/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "UIView+TWTAdditions.h"


@implementation UIView (TWTAdditions)

// From: http://stackoverflow.com/questions/949806/is-there-a-way-to-detect-what-uiview-is-currently-visible
- (UIView *)findFirstResonder {
    if (self.isFirstResponder) {        
        return self;     
    }
	
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResonder];
		
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
	
    return nil;
}

@end
