//
//  NSString+TWTAdditions.h
//  TWTCommon
//
//  Created by Jeremy Ellison on 8/26/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (TWTAdditions)

+ (id)stringWithFormat:(NSString *)format array:(NSArray*) arguments;

@end
