//
//  ValueDictionary.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 27/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "ValueDictionary.h"

@interface ValueDictionary () {
    NSMapTable *_valuesByVariable;
}

@end

@implementation ValueDictionary

- (instancetype)init
{
    self = [super init];
    if (self) {
        _valuesByVariable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    }
    return self;
}

- (NSNumber *)objectForKeyedSubscript:(Variable *)key
{
    return [_valuesByVariable objectForKey:key];
}

- (void)setObject:(NSNumber *)value forKeyedSubscript:(Variable *)key
{
    [_valuesByVariable setObject:value forKey:key];
}

@end
