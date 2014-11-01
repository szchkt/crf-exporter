//
//  IntegerValueTransformer.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "IntegerValueTransformer.h"

#import "NSString+Extensions.h"

@implementation IntegerValueTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [value stringValue];
}

- (id)reverseTransformedValue:(id)value
{
    return @([value integerValue]);
}

@end
