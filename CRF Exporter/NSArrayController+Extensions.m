//
//  NSArrayController+Extensions.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "NSArrayController+Extensions.h"

@implementation NSArrayController (Extensions)

- (void)removeAllObjects
{
    NSRange range = NSMakeRange(0, [[self arrangedObjects] count]);
    if (range.length) {
        [self removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    }
}

@end
