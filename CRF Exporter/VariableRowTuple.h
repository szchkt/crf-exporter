//
//  VariableRowTuple.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 01/11/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variable;
@class Row;

@interface VariableRowTuple : NSObject

@property (nonatomic, readonly) Variable *variable;
@property (nonatomic, readonly) Row *row;

+ (instancetype)tupleWithVariable:(Variable *)variable row:(Row *)row;

@end
