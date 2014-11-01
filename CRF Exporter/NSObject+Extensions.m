//
//  NSObject+Extensions.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "NSObject+Extensions.h"

@implementation NSObject (Extensions)

- (instancetype)nonNullValue
{
    return self == [NSNull null] ? nil : self;
}

@end
