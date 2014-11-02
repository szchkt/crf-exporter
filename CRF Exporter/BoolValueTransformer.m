//
//  BoolValueTransformer.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 01/11/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "BoolValueTransformer.h"

@implementation BoolValueTransformer

+ (Class)transformedValueClass
{
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    return @([value boolValue]);
}

@end
