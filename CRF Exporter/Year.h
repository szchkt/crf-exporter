//
//  Year.h
//  CRF Exporter
//
//  Created by Michal Tomlein on 27/10/14.
//  Copyright (c) 2014 SZ CHKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Row;
@class ValueDictionary;

@interface Year : NSObject

@property (nonatomic, readonly) NSInteger year;

- (instancetype)initWithYear:(NSInteger)year;

- (ValueDictionary *)objectForKeyedSubscript:(Row *)row;
- (void)setObject:(ValueDictionary *)valueDictionary forKeyedSubscript:(Row *)key;

@end
