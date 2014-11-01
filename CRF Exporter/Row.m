//
//  Row.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 26/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "Row.h"

#import "NSObject+Extensions.h"

static NSString *const kRowUUIDKey = @"id";
static NSString *const kRowIndexKey = @"rowIndex";
static NSString *const kRowCategoryKey = @"category";
static NSString *const kRowClassificationKey = @"classification";
static NSString *const kRowMethodKey = @"method";
static NSString *const kRowTargetKey = @"target";
static NSString *const kRowOptionKey = @"option";
static NSString *const kRowTypeKey = @"type";
static NSString *const kRowGasKey = @"gas";

@implementation Row

- (instancetype)init
{
    self = [super init];
    if (self) {
        _UUID = [[NSUUID UUID] UUIDString];
        _category = @"no category";
        _classification = @"no classification";
        _method = @"no method";
        _target = @"no target";
        _option = @"no option";
        _type = @"no type";
        _gas = @"no gas";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _UUID = [dictionary[kRowUUIDKey] nonNullValue] ?: [[NSUUID UUID] UUIDString];
        _rowIndex = [[dictionary[kRowIndexKey] nonNullValue] integerValue];
        _category = [dictionary[kRowCategoryKey] nonNullValue];
        _classification = [dictionary[kRowClassificationKey] nonNullValue];
        _method = [dictionary[kRowMethodKey] nonNullValue];
        _target = [dictionary[kRowTargetKey] nonNullValue];
        _option = [dictionary[kRowOptionKey] nonNullValue];
        _type = [dictionary[kRowTypeKey] nonNullValue];
        _gas = [dictionary[kRowGasKey] nonNullValue];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    return @{kRowUUIDKey: self.UUID ?: [NSNull null],
             kRowIndexKey: @(self.rowIndex),
             kRowCategoryKey: self.category ?: [NSNull null],
             kRowClassificationKey: self.classification ?: [NSNull null],
             kRowMethodKey: self.method ?: [NSNull null],
             kRowTargetKey: self.target ?: [NSNull null],
             kRowOptionKey: self.option ?: [NSNull null],
             kRowTypeKey: self.type ?: [NSNull null],
             kRowGasKey: self.gas ?: [NSNull null]};
}

@end
