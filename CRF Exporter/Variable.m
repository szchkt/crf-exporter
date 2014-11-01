//
//  Variable.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "Variable.h"

#import "NSObject+Extensions.h"

static NSString *const kVariableUUIDKey = @"id";
static NSString *const kVariableNameKey = @"name";
static NSString *const kVariableColumnIndexKey = @"columnIndex";
static NSString *const kVariableMeasureKey = @"measure";
static NSString *const kVariableUnitKey = @"unit";

@implementation Variable

- (instancetype)init
{
    self = [super init];
    if (self) {
        _UUID = [[NSUUID UUID] UUIDString];
        _measure = @"no measure";
        _unit = @"no unit";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _UUID = [dictionary[kVariableUUIDKey] nonNullValue] ?: [[NSUUID UUID] UUIDString];
        _name = [dictionary[kVariableNameKey] nonNullValue];
        _columnIndex = [[dictionary[kVariableColumnIndexKey] nonNullValue] integerValue];
        _measure = [dictionary[kVariableMeasureKey] nonNullValue];
        _unit = [dictionary[kVariableUnitKey] nonNullValue];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{kVariableUUIDKey: self.UUID ?: [NSNull null],
             kVariableNameKey: self.name ?: [NSNull null],
             kVariableColumnIndexKey: @(self.columnIndex),
             kVariableMeasureKey: self.measure ?: [NSNull null],
             kVariableUnitKey: self.unit ?: [NSNull null]};
}

- (NSString *)description
{
    return self.name;
}

- (NSString *)debugDescription
{
    return [super description];
}

@end
