//
//  NSString+TWTAdditions.m
//  TWTCommon
//
//  Created by Jeremy Ellison on 8/26/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "NSString+TWTAdditions.h"


@implementation NSString (TWTAdditions)

// From http://stackoverflow.com/questions/1058736/how-to-create-a-nsstring-from-a-format-string-like-xxx-yyy-and-a-nsarra
+ (id)stringWithFormat:(NSString *)format array:(NSArray*) arguments {
    char *argList = (char *)malloc(sizeof(NSString *) * [arguments count]);
    [arguments getObjects:(id *)argList];
    NSString* result = [[[NSString alloc] initWithFormat:format arguments:argList] autorelease];
    free(argList);
    return result;
}

@end
