//
//  TTSectionedDataSource+TWTAdditions.h
//  TWTCommon
//
//  Created by Blake Watters on 9/7/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface TTSectionedDataSource (TWTAdditions)

/**
 * Returns the next table item to the TTTableControlItem containing the specified control
 */
- (TTTableItem*)nextSiblingTableItemToControl:(UIControl*)control;

/**
 * Returns the next control from the sibling TTTableControlItem containing the specified control
 */
- (UIControl*)nextSiblingControlToControl:(UIControl*)control;

@end
