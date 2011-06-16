//
//  TWTURLButton.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 6/15/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//

#import "TWTURLButton.h"
#import <Three20/Three20.h>

@implementation TWTURLButton

@synthesize clickUrl = _clickUrl;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonClicked {
    if (_clickUrl) {
        TTOpenURL(_clickUrl);
    }
}

@end
