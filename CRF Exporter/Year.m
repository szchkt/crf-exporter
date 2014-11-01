//
//  Year.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 27/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "Year.h"

@interface Year () {
    NSMapTable *_valuesByRow;
}

@end

@implementation Year

- (instancetype)initWithYear:(NSInteger)year
{
    self = [super init];
    if (self) {
        _year = year;
        _valuesByRow = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    }
    return self;
}

- (ValueDictionary *)objectForKeyedSubscript:(Row *)row
{
    return [_valuesByRow objectForKey:row];
}

- (void)setObject:(ValueDictionary *)valueDictionary forKeyedSubscript:(Row *)key
{
    [_valuesByRow setObject:valueDictionary forKey:key];
}

@end
