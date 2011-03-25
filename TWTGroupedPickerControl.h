//
//  TWTGroupedPickerControl.h
//  TWTCommon
//
//  Created by Jeremy Ellison on 12/3/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "TWTPickerControl.h"


@interface TWTGroupedPickerControl : TWTPickerControl {

}

- (NSArray*)rowsForComponent:(NSInteger)component replaceOptionTitlesWithNULL:(BOOL)replace;

@end
