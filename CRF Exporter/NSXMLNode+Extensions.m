//
//  NSXMLNode+Extensions.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 01/11/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "NSXMLNode+Extensions.h"

@implementation NSXMLNode (Extensions)

- (NSInteger)integerValue
{
    return [[self stringValue] integerValue];
}

- (double)doubleValue
{
    return [[self stringValue] doubleValue];
}

- (BOOL)boolValue
{
    return [[self stringValue] boolValue];
}

@end
