//
//  TWTURLButton.h
//  TWTCommon
//
//  Created by Jeremy Ellison on 6/15/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TWTURLButton : UIButton {
    NSString* _clickUrl;
}

@property (nonatomic, copy) NSString* clickUrl;

@end
