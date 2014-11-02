//
//  VariableRowTuple.m
//  CRF Exporter
//
//  Created by Michal Tomlein on 01/11/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import "VariableRowTuple.h"

@implementation VariableRowTuple

- (instancetype)initWithVariable:(Variable *)variable row:(Row *)row
{
    self = [super init];
    if (self) {
        _variable = variable;
        _row = row;
    }
    return self;
}

+ (instancetype)tupleWithVariable:(Variable *)variable row:(Row *)row
{
    return [[[self class] alloc] initWithVariable:variable row:row];
}

@end
