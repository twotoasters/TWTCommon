//
//  TWTPickerDataSource.h
//  TWTCommon
//
//  Created by Jeremy Ellison on 9/9/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TWTPickerDataSource : NSObject {
	NSArray* _components;
}

@property (nonatomic, copy) NSArray* components;

- (id)initWithComponents:(NSArray*)components;

// For pickers with just 1 component.
- (id)initWithRows:(NSArray*)rows;

@end
